
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

async function getXp(username){
    return await psql.query("SELECT xp from student where username = $1", [username])
};

async function addXp(username,xp){
    return await psql.query("UPDATE student set xp = $1 where username = $2", [xp,username])
};

exports.handler = async (event, context, callback) => {
    var username = event.username;
    var esp = event.xp;
    var oldXp = await getXp(username)
    var newxP;

    if (oldXp == "err"){
        return {
          "statusCode": 404,
          "isBase64Encoded": false,
          "body": JSON.stringify({message: 'User not found'}),
        }
    }
    else{
        var exp = oldXp.rows[0].xp;
        newxP = exp+esp;

        var control = await addXp(username,newxP);
        
        if (control == "err"){
            return {
              "statusCode": 404,
              "isBase64Encoded": false,
              "body": JSON.stringify({message: 'col cazzo che te la aggiorno'}),
            }
        }
        else{
            return {
                "statusCode": 200,
                "isBase64Encoded": false,
                "body": JSON.stringify({message: 'ok'}),
              }
        }
    }
    /*return {
        "statusCode": 200,
        "isBase64Encoded": false,
        "body": JSON.stringify(username),
    }*/
}