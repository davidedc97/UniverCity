const AWS = require('aws-sdk');
global.fetch = require('node-fetch');

var Pool = require('pg').Pool;

const psql = new Pool ({
    host: '',
    user: '',
    password: '',
    database: '',
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

async function delFav(fav,username){
    return await psql.query("DELETE FROM favourite WHERE docs = $1 and username = $2", [fav,username])
};

async function getFav(fav,username){
    return await psql.query("SELECT * FROM favourite WHERE docs = $1 and username = $2", [fav,username])
}

exports.handler = async (event) => {
    
    var username = event.queryStringParameters.username;
    var fav = event.queryStringParameters.uuid;
    var resultGet = await getFav(fav,username);
    var resultDel = await delFav(fav,username);
    
    if (resultGet.rows.length == 0 || resultGet == 'err'){
        return {
          "statusCode": 404,
          "isBase64Encoded": false,
          "headers": {},
          "body": JSON.stringify({message: 'User not found or document not found'}),
        }
    }
    else if (resultDel == 'err'){
        return {
          "statusCode": 400,
          "isBase64Encoded": false,
          "headers": {},
          "body": JSON.stringify({message: 'Deletion failed'}),
        }
    }
    
    else{
        return {
          "statusCode": 200,
          "isBase64Encoded": false,
          "headers": {},
          "body": JSON.stringify({message: 'ok'}),
        }
    }

        /*return {
        "statusCode": 200,
        "isBase64Encoded": false,
        "body": JSON.stringify(result),
        }*/
}