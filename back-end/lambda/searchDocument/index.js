
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

async function searchDoc(title){
    return await psql.query('SELECT * FROM document where title LIKE $1', [`%${title}%`])
  };

  exports.handler = async (event) => {

    const title = event.queryStringParameters.searchString;
  
    const result = await searchDoc(title)
  
    if (result == "err") {
      return {
        "statusCode": 404,
        "isBase64Encoded": false,
        "body": JSON.stringify({message: 'Doc not found'}),
      }
    }
    else{
      
      var responseBody = {
          "num": result.rows.length,
          "docs": []
      }
      
      var c
      for (c = 0; c<result.rows.length; c++){
        responseBody.docs[c] = result.rows[c];
      }
      return {
          "statusCode": 200,
          "isBase64Encoded": false,
          "body": JSON.stringify(responseBody),
      }
    }
  
};