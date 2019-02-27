'use strict';

var Express = require("express");
var AWS = require('aws-sdk');
var AWS = require('aws-sdk/global'); // gestione aws
var S3 = require('aws-sdk/clients/s3'); // gestione aws
var path = require('path'); // gestione aws
var fs = require('fs'); // gestione aws 
var BodyParser = require("body-parser");
var multer = require('multer'); 
var upload = multer();
var hummus = require('hummus');
var fs = require('fs');
var streams = require('memory-streams');
var PDFRStreamForBuffer = require('./pdfr-stream-for-buffer.js');
var request = require("request");
var app = Express();

app.use(BodyParser.json({limit: "4mb"}));
app.use(Express.static(__dirname));

const {DYNAMO_ENDPOINT} = process.env;

/*AWS.config.update({
    region: "us-west-2",
    endpoint: DYNAMO_ENDPOINT
});*/

/*
** #############################
** # Gestione bucket amazon S3 #
** #############################
*/

AWS.config.update({
    accesKeyId: "AKIAJY5LRLNDA3O3Z7IA",
    secretAccesKey: "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"
});
var s3 = new AWS.S3();

var params = {
    Bucket: "univercitybuck"
    //Body: fs.createReadStream(filePath),
    //key: "folder/"+Date.now()+"_"+Path2D.basename(filePath)
};
  
var dynamodb = new AWS.DynamoDB();

//https://docs.minio.io/docs/javascript-client-api-reference
//https://docs.aws.amazon.com/AWSJavaScriptSDK/latest/AWS/S3.html
//PDF
//https://github.com/jjwilly16/node-pdftk

var s3  = new AWS.S3({
    accessKeyId: 'Q3AM3UQ867SPQQA43P2F' ,
    secretAccessKey: 'zuf+tfteSlswRu7BJ86wekitnifILbZam1KYY3TG' ,
    endpoint: 'http://storage:9000' ,
    s3ForcePathStyle: true, // needed with minio?
    signatureVersion: 'v4'
});

app.get("/", function(request, response) {
    response.send("The server works properly!");
});

//##################################################################################################
//FUNZIONI AUSILIARIE

const getNthPage = function (buffer,idx,maxPages) {
    //Creating a stream, so hummus pushes the result to it
    let outStream = new streams.WritableStream();
    //Using PDFStreamForResponse to be able to pass a writable stream
    let pdfWriter = hummus.createWriter(new hummus.PDFStreamForResponse(outStream));

    if(idx >= maxPages){
        return null;
    };

    //Using our custom PDFRStreamForBuffer adapter so we are able to read from buffer
    let copyingContext = pdfWriter.createPDFCopyingContext(new PDFRStreamForBuffer(buffer));
    //Get the first page.
    copyingContext.appendPDFPageFromPDF(idx);

    //We need to call this as per docs/lib examples
    pdfWriter.end();

    //Here is a nuance.
    //HummusJS does it's work SYNCHRONOUSLY. This means that by this line
    //everything is written to our stream. So we can safely run .end() on our stream.
    outStream.end();


    //As we used 'memory-stream' and our stream is ended
    //we can just grab stream's content and return it
    return outStream.toBuffer();
};

//##################################################################################################
/**
 * 
 * POST /document
 */


function putPage(key,body){
    var params = {
        Body: body,
        Bucket: "test", 
        Key: key
    };

    s3.putObject(params, function(err, data) {
         if (err){
             console.log(err, err.stack);
             return 1;
         }
         else{
             return 0;
         }
    });
}

var pagePromise = function(idx,buffer,maxPages){
    return new Promise(function(resolve,reject){
        var page = getNthPage(buffer,idx,maxPages);

        //Creating the hash
        var hash = require('crypto').createHash('sha1');
        hash.update(page.toString("utf-8").substring(0,2000));
        var id = hash.digest("hex");

        var params = {
            Bucket: "test", 
            Key: id
        };

        //Checking if the page already exists in the storage
        s3.headObject(params, function(err, data) {
            //If it doesn't exist it is added
            if(err && err.code === "NotFound"){
                putPage(id,page);
                resolve({"e":0,"id":id});
            }
            else if (err){
                console.log("Error: " + err);
                reject(err);
            }
            //Otherwise I don't
            else{
                console.log("[*] The page already exists");
                resolve({"e":1,"id":id});
            }
        });
    });
}

app.post("/document", upload.any(), function(req,res){
    if(req.files){
        console.log('[*] POST /document');

        if(req.files[0].mimetype !== "application/pdf"){
            res.status(500).send('You should send a pdf file');
        }
        else{
            var buffer = req.files[0].buffer;

            var pdfReader = hummus.createReader(new PDFRStreamForBuffer(buffer));
            var maxPages = pdfReader.getPagesCount();
    
            var promises = [];
    
            //Splitting the pdf in pages. They are stored in the storage according to their id.
            for(var i=0; i < maxPages; i++){
                promises.push(pagePromise(i,buffer,maxPages));            
            }

            Promise.all(promises).then(function(values){
                console.log(JSON.stringify(values));
                var ids = [];
                //var pagesToAdd = [];
                var counter = 0;
                var len = values.length; 
                for(var i=0; i < len; i++){
                    ids[i] = values[i].id;
                    counter += values[i].e;
                }

                console.log("[*] Ids: " + JSON.stringify(ids));

                var type = "M";
                //If counter === 0 the document is original
                if(counter === 0){
                    type = "O";
                }
                
                //I suppose that the creator is consistent so it will exist
                //Send request to metaserver
                request({ method: 'POST',
                        uri: 'http://metaserver:8888/original',
                        headers: {'content-type': 'application/json'},
                        body: JSON.stringify({"creator": "1","type": type,"pages": ids})
                    }, function (error, response, body) {
                    if(error){
                        console.log('[*] Error ' + response.statusCode + ': ' + response);
                        res.status(500).send(error.code);
                    }
                    else if(response.statusCode === 201){
                        console.log("[*] Fine");
                        res.status(200).send(type);
                    }
                    else {
                        console.log('[*] Error ' + response.statusCode + ': ' + response.body);
                        res.status(500).send(response);
                    }
                });

            }).catch(function(err){
                //TO DO
                //Error handler
                console.log("[*] Error " + err);
                res.status(500).send("no");
            });

        }
    }
    else{
        res.status(400).send("Bad parameter");
    }
});


//######################################################################################################
/**
 * 
 * GET /document
 */

var getPagePromise = function(id){
    return new Promise(function(resolve,reject){
        var params = {Bucket: 'test', Key: id};
        s3.getObject(params, function(err,data){
            if(err){
                console.log("Error: " + err);
                reject(err);
            }
            else{
                resolve(data.Body);
            }
        });
    });
}

const downloadFiles = (pages,res) => {
    var promises = [];

    for(let id of pages) {
        promises.push(getPagePromise(id));
    }

    //Because the access to the storage is async I need to wait for the pages to be retrieved in order
    Promise.all(promises).then(function(buffers){

        //If everything is fine 'buffers' will contain the buffers of the pages
        console.log("[*] Sending res");
        res.writeHead(200, {'Content-Type': 'application/pdf'});

        //I create a pdf stream on res
        var pdfWriter = hummus.createWriter(new hummus.PDFStreamForResponse(res));      

        for(let i=0; i < pages.length; i++) {
            try{
                //Since the pages are saved in the storage as one-page pdf documents I need to extract
                //the first and only page and add to the stream
                let copyingContext = pdfWriter.createPDFCopyingContext(new PDFRStreamForBuffer(buffers[i]));
                copyingContext.appendPDFPageFromPDF(0);
            }
            catch(err){
                //In case of error I skip the fault page
                console.log("[*] Buffer " + i + " failed: " + err);
            }
        }

        pdfWriter.end();
        res.end();
    }).catch(function(err){
        //This error is caused by an error in the storage
        console.log("[*] " + err);
        res.status(500).send(err);
    });

}

const getPagesForDoc = function(doc){
    return new Promise(function(resolve,reject){
        var params = {
            Key: {
             "docID": {
               S: doc
              },
            },
            AttributesToGet: [
                'pages',
            ], 
            TableName: "documents"
        };
        dynamodb.getItem(params, function(err, data) {
            if (err){
                console.log(err, err.stack);
                reject(err);
            }
            else if(!data.Item){
                console.log("[*] Document not found");
                reject("404");
            }
            else{
                console.log(data.Item.pages.SS);
                resolve(data.Item.pages.SS);
            }
        });
    });
}

app.get("/document", function(req,res){
    if(req.query.id){

        //get the pages id from the metaServer
        getPagesForDoc(req.query.id).then(function(pages){
            downloadFiles(pages,res);
        }).catch(function(err){
            if(err === "404") res.status(404).send("Document not found");
            else res.status(500).send(err);
        });
    }
    else{
        res.status(400).send("Bad parameter");
    }
});






//###################################################################################################

var server = app.listen(3000, function() {
    console.log("[*] Listening on port %s...", server.address().port);
});