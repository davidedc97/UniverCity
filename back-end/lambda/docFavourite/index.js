const AWS = require('aws-sdk');
global.fetch = require('node-fetch');

var Pool = require('pg').Pool;

const psql = new Pool ({
    host: 'metadata.czzhwg1jheui.eu-west-1.rds.amazonaws.com',
    user: 'univercity',
    password: 'googleworkshop',
    database: 'metadata',
    port: 5432
})

var fav = null;

/*function getFavourite(username){
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
}*/

async function getFavourite(username){
    return await psql.query("SELECT * from favourite where username = $1", [username])
};

exports.handler = async (event) => {
    
    var username = event.queryStringParameters.username;
    var result = await getFavourite(username);
    var fav = [];

    if (result == "err"){
        return {
          "statusCode": 404,
          "isBase64Encoded": false,
          "headers": {},
          "body": JSON.stringify({message: 'User not found'}),
        }
    }
    else {
        var i;
        for (i = 0; i<result.rows.length; i++){
            fav[i] = result.rows[i].docs;
        }

        var responseBody = {
            "num": fav.length,
            "favourite": fav
        },

        fav = []

        return {
          "statusCode": 200,
          "isBase64Encoded": false,
          "headers": {},
          "body": JSON.stringify(responseBody),
        }
        /*return {
        "statusCode": 200,
        "isBase64Encoded": false,
        "body": JSON.stringify(result),
        }*/
    }
}