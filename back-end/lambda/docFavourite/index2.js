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

async function postFav(fav,username){
    return await psql.query("INSERT INTO favourite VALUES ($1,$2)", [username,fav])
};

async function controlFav(fav,username){
    return await psql.query("SELECT * FROM favourite WHERE username = $1 and docs = $2", [username,fav])
};


exports.handler = async (event) => {
    var body = JSON.parse(event.body)
    var username = body.username;
    var fav = body.uuid;
    var resultControl = await controlFav(fav,username);
    var resultPost;
    
    if (resultControl.rows.length == 1 || resultControl == 'err'){
        return {
          "statusCode": 404,
          "isBase64Encoded": false,
          "headers": {},
          "body": JSON.stringify({message: 'Doc already exist or db error'}),
        }
    }
    else {
        resultPost = await postFav(fav,username);
        
        if (resultPost == 'err'){
            return {
                "statusCode": 400,
                "isBase64Encoded": false,
                "headers": {},
                "body": JSON.stringify({message: 'Post error'}),
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
    }

        /*return {
        "statusCode": 200,
        "isBase64Encoded": false,
        "body": JSON.stringify(result),
        }*/
}
