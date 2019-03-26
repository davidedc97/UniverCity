const AWS = require('aws-sdk');
global.fetch = require('node-fetch');
const multer = require('multer');
const multerS3 = require('multer-s3');

var Pool = require('pg').Pool;

const psql = new Pool ({
    host: 'metadata.czzhwg1jheui.eu-west-1.rds.amazonaws.com',
    user: 'univercity',
    password: '',
    database: 'metadata',
    port: 5432
})

AWS.config.update({
    secretAccesKey: "",
    accesKeyId: "",
    region: "eu-west-2"
})

var s3 = new AWS.S3();

var params = {
    Bucket: "uni-user-profile-image",
    Key: "",
    Body: "",
    ACL: "public-read"
}

function putImg(img, username){
    var path = "https://uni-user-profile-image.s3.amazonaws.com/" + username + "-img"; //da definisre e studiare
    params.body = img;

    return new Promise((resolve, reject) => {
        s3.putObject(params, function(err,res){
            if (err) resolve("err");
            else{
                psql.query("UPDATE image VALUE ($1) from utilitator where username = $2", [path,username], {
                    onSucces: function(res){
                        resolve(res.rows);
                    },
                    onFailure: function(err){
                        resolve("err");
                    },
                });
            } 
        })
    });
}

exports.handler = async (event, context, callback) => {
    var body = JSON.parse(event.body);
    
    var username = body.username;
    var img = body.img;

    var response = {
        "statusCode": 200,
        "isBase64Encoded": false,
        "body": {},
    }
    
    try{
        var result = await putImg(img, username).then((result) => {
            return result;
        });
        
        var statusCode = 200;
        var body = result;
        if(result == "err"){
            statusCode = 400;
            body = "user not found";
        }
        
        response.statusCode = statusCode;
        response.body = body;
        
        callback(null,response);
    }
    catch(e){
        callback(e,{
            "isBase64Encoded": false,
            "headers": {},
            "body": "err",
            "statusCode": 501
        });
    }
};

