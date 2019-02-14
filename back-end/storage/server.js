'use strict';

var Express = require("express");
var AWS = require('aws-sdk');
var BodyParser = require("body-parser");
var multer = require('multer'); 
var upload = multer();
var hummus = require('hummus');
var fs = require('fs');
var streams = require('memory-streams');
var PDFRStreamForBuffer = require('./pdfr-stream-for-buffer.js');
var app = Express();

app.use(BodyParser.json({limit: "4mb"}));
app.use(Express.static(__dirname));

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
    //let pdfReader = hummus.createReader(new PDFRStreamForBuffer(buffer));
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
        hash.update(page.toString("utf-8"));
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
                console.log("The page already exists");
                resolve({"e":1,"id":id});
            }
        });
    });
}

app.post("/document", upload.any(), function(req,res){
    if(req.files){
        console.log('POST /document');
        console.log('Files: ', req.files);

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
                var counter = 0;
                var ids = [];
                for(var i=0; i < values.length; i++){
                    ids.push(values[i].id);
                    counter += values[i].e;
                }

                //If counter === 0 the document is original
                if(counter === 0){
                    //TO DO
                    //Send request to server
                    console.log("[*] 'POST /doc' to metaServer => ORIGINAL");
                    res.status(200).send("original");
                }
                else {
                    //TO DO
                    //Send request to server
                    console.log("[*] 'POST /doc' to metaServer => MASH-UP");
                    res.status(200).send("mash-up");
                }
            }).catch(function(err){
                //TO DO
                //Error handler
                console.log("Error");
            });

        }
    }
});


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
        res.status(500).send("Error");
    });

}

app.get("/document", function(req,res){
    if(req.query.id){

        //TO DO
        //get the pages id from the metaServer

        var page1 = "21142dc434f7881426efd3605de746fb87d52a23";
        var page2 = "7fc6ab186ccccf407ceb4c1e119d20799bcb5df1";
        var pages = [page1,page2];

        //The array 'pages' will contain the IDs of the requested pages
        downloadFiles(pages,res);
    }
});













//###################################################################################################à
//Function that I just used to check if everything was ok

app.get("/tmp", function(req,res){
    var id = "prova.pdf";
    var w = fs.createWriteStream("./tmp/" + id + ".pdf");

    var params = {Bucket: 'test', Key: id};
    var stream = s3.getObject(params, function(err,data){
        if(err){
            console.log("Error: " + err);
        }
    }).createReadStream();

    stream.on('data', function(data) {
        w.write(data);
    });

    stream.on('finish', function() {
        w.end(function(){
        console.log("[*] Prima");
        var pdfWriter = hummus.createWriter(new hummus.PDFStreamForResponse(res));
        //let copyingContext = pdfWriter.createPDFCopyingContext(new PDFRStreamForBuffer(b));
        //Get the first page.
        //copyingContext.appendPDFPageFromPDF(0);
        pdfWriter.appendPDFPagesFromPDF("./tmp/" + id + ".pdf");
        pdfWriter.end();
        res.end();
        });
    });
});

app.post("/tmp", upload.any(), function(req,res){
    if(req.files && req.body.name){
        console.log('POST /document');
        console.log('Files: ', req.files);
        
        var buffer = req.files[0].buffer;

        if(putPage(req.body.name,buffer)) res.status(500).send();
        else res.status(200).send();
    }
    else{
        res.status(500).send();
    }
});



var server = app.listen(3000, function() {
    console.log("[*] Listening on port %s...", server.address().port);
});