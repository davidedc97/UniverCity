'use strict';

var Express = require("express");
var AWS = require('aws-sdk');
//var BodyParser = require("body-parser");
//var multer = require('multer'); 
//var upload = multer();
var hummus = require('hummus');
//var fs = require('fs');
//var streams = require('memory-streams');
//var PDFRStreamForBuffer = require('./pdfr-stream-for-buffer.js');
//var uuidv1 = require('uuid/v1');
var app = Express();

const awsServerlessExpressMiddleware = require('aws-serverless-express/middleware')
app.use(awsServerlessExpressMiddleware.eventContext())

var s3 = new AWS.S3();

//app.use(BodyParser.json({limit: "4mb"}));
  
var dynamodb = new AWS.DynamoDB();

//app.get('/', (req, res) => res.send('Hello world!'))

function putPage(key,body){
    var params = {
        Body: body,
        Bucket: "univercity-bucket", 
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


var getPagePromise = function(id){
    return new Promise(function(resolve,reject){
        var params = {Bucket: 'univercity-bucket', Key: id};
        s3.getObject(params, function(err,data){
            if(err){
                console.log("Error: " + err);
                reject(err);
            }
            else{
                console.log("[*] The page exists\n");
                resolve(data.Body);
            }
        });
    });
}

const downloadFiles = (pages,res) => {
    var promises = [];

    for(let page of pages) {
        promises.push(getPagePromise(page.S));
    }


    //Because the access to the storage is async I need to wait for the pages to be retrieved
    Promise.all(promises).then((buffers) => {

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
             "ID": {
               S: doc
              },
            },
            AttributesToGet: [
                'pages',
            ], 
            TableName: "Documents"
        };
        dynamodb.getItem(params, function(err, data) {
            if (err){
                console.log(err, err.stack);
                reject("no");
            }
            else if(!data.Item){
                console.log("[*] Document not found");
                reject("404");
            }
            else{
                resolve(data.Item.pages.L);
            }
        });
    });
}

app.get("/", function(req,res){
    //get the pages id from the metaServery
    var id = req.apiGateway.event.params.querystring.id;
    getPagesForDoc(id).then(function(pages){
        downloadFiles(pages,res);
    }).catch(function(err){
        console.log(err);
        if(err === "404") res.status(404).send("Document not found");
        else res.status(500).send("Error: " + err.code);
    });

});


module.exports = app