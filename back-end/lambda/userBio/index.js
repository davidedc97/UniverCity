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

async function searchUser(username,bio){
  return await psql.query("UPDATE student set bio = $1 where username = $2", [bio,username])
  };

exports.handler = async (event) => {
    const username = event.username;
    const bio = event.bio;

    const result = await searchUser(username,bio)
  
    var i;
    for (i = 0; i< result.rows.length; i++){
        ret.push(result.rows[i].username);
    }
    if (result == "err") {
      return {
        "statusCode": 404,
        "isBase64Encoded": false,
        "body": JSON.stringify({message: 'User not found'}),
      }
    }
    return {
      "statusCode": 200,
      "isBase64Encoded": false,
      "body": JSON.stringify({message: 'ok'}),
    }
  
};

