
const AWS = require('aws-sdk');
global.fetch = require('node-fetch');

var Pool = require('pg').Pool;

const psql = new Pool ({
    host: 'metadata.czzhwg1jheui.eu-west-1.rds.amazonaws.com',
    user: 'univercity',
    password: '',
    database: 'metadata',
    port: 5432
})

var result = null;
var doc = null;

function getMetadata(username){

    return new Promise((resolve, reject) => {
        psql.query("SELECT * from utilitator where username = $1", [username], function(err, res){
            if (err) result = "err";
            else {
                result = res.rows;
            }
        })
        if(result == "err") resolve(result);
        else {
            psql.query("SELECT * from creator where student = $1", [username], {
                onSucces: function(rsl){
                    for (i = 0; i<rsl.rows.lenght; i++){
                        doc[i] = rsl.rows[i].document;
                    }
                    resolve(result);
                },
                onFailure: function(error){
                    result = "err";
                    resolve(result);
                }
            });
        }
    });
}

exports.handler = async (event, context, callback) => {
    var body = JSON.parse(event.body);
    
    var username = body.username;

    var response = {
        "statusCode": 200,
        "isBase64Encoded": false,
        "body": {
            "imgUserPath": result[0].image,
            "username": result[0].username,
            "name": result[0].name,
            "surname": result[0].surname,
            "xp": result[0].xp,
            "bio": result[0].bio,
            "documentUploaded": {
                "num": doc.lenght,
                "docs": [
                    {
                        "title": "",
                        "uuid": ""
                    }
                ]
             },
            "mashupCreated": {
                "num": 0,
                "docs": [
                    {
                        "title": "",
                        "uuid": ""
                    }
                ]
            }
        },
    }

    for (i=0; i< doc.lenght; i++){
        response.body.docs[i] = doc[i];
    }
    
    try{
        var result = await getMetadata(username).then((result) => {
            return result;
        });
        
        var statusCode = 200;
        if(result == "err"){
            statusCode = 400;
            body = "user not found";
        }
        
        response.statusCode = statusCode;
        
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

