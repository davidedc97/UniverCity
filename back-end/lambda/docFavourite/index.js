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

var fav = null,

function getFavourite(username){
    return new Promise((resolve, reject) => {
        psql.query("SELECT * from favourite where username = $1", [username], {
            onSucces: function(res){
                for(i = 0; i<res.rows.lenght; i++){
                    fav[i] = res.rows[i].docs;
                }
                resolve(fav);
            },
            onFailure: function(error){
                resolve("err");
            }
        });
    });
}

exports.handler = async (event, context, callback) => {
    var body = JSON.parse(event.body);
    
    var username = body.username;

    var response = {
        "statusCode": 200,
        "isBase64Encoded": false,
        "body": {
            "num": fav.lenght,
            "favourite": [
                ""
            ]
        }
    }
    
    for(i = 0, i<fav.lenght; i++){
        response.body.favourite[i] = fav[i];
    }

    try{
        var result = await getFavourite(username).then((result) => {
            return result;
        });
        
        if(result == "err"){
            response.statusCode = 400;
            response.body = "user not found";
        }
        
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

