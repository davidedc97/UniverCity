
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

/*var test = [];
var control;

async function searchUser(username){

    var result;

    await psql.query("SELECT username from utilitator where username = $1", [username], function(err, res){
        if (err) control = "err";
        else {
            result = res.rows;
            var i;
            for (i = 0; i<result.length; i++){
                test.push(result[i].username);
            }
        } 
    })
}

exports.handler = async (event) => {
    //const body = JSON.parse(event.body);
  
    const username = event.username;
    await searchUser(username);

    if (control == "err") {
      return {
        "statusCode": 404,
        "isBase64Encoded": false,
        "body": JSON.stringify({message: 'User not found'}),
      }
    }
    return {
      "statusCode": 200,
      "isBase64Encoded": false,
      "body": JSON.stringify(test)
    }
  
  };
*/

async function searchUser(username){
    return await psql.query('SELECT username FROM utilitator where username LIKE $1', [`%${username}%`])
  };

  exports.handler = async (event) => {
    //const body = JSON.parse(event.body);
    var ret = [];
    const username = event.username;
  
    const result = await searchUser(username)
  
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
      "body": JSON.stringify(ret),
    }
  
};