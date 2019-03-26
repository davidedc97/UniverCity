gconst AWS = require('aws-sdk');
global.fetch = require('node-fetch');

var Pool = require('pg').Pool;

const psql = new Pool ({
    host: 'metadata.czzhwg1jheui.eu-west-1.rds.amazonaws.com',
    user: 'univercity',
    password: '',
    database: 'metadata',
    port: 5432
})

function getMetadata(username){
    return new Promise((resolve, reject) => {
        psql.query("SELECT image from utilitator where username = $1", [username], {
            onSucces: function(res){
                resolve(res.rows);
            },
            onFailure: function(err){
                resolve("err");
            },
        });
    });
}

exports.handler = async (event, context, callback) => {
    var body = JSON.parse(event.body);
    
    var username = body.username;

    var response = {
        "statusCode": 200,
        "isBase64Encoded": false,
        "body": {},
    }
    
    try{
        var result = await getMetadata(username).then((result) => {
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

