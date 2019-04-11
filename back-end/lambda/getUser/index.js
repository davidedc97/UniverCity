
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

var result = [];
var doc = [];

/*async function getMetadata(username){
    await psql.query("SELECT * from utilitator where username = $1", [username], function(err, res1){
        if (err) result = "err";
        else {
            result = res1.rows;
        }
    })
    if(result == "err") return "err";
    else {
        await psql.query("SELECT * from creator where student = $1", [username], function(err, res2) {
            if (err) return "err";
            else { 
                for (i = ; i<res2.rows.lenght; i++){
                    doc[i] = res2.rows[i].document;
                }
            }
        })
    }
}*/

async function getMetadataUti(username){
    return await psql.query("SELECT * from student where username = $1", [username])
};

async function getMetadataCreator(student){
    return await psql.query("SELECT * from creator where student = $1", [student])
};

exports.handler = async (event, context, callback) => {
    //var body = JSON.parse(event.body)
    var username = event.queryStringParameters.username;
    var resultUti = await getMetadataUti(username)
    var resultCreator = await getMetadataCreator(username)
        
    if(resultUti == "err"){
        return {
            "statusCode": 404,
            "isBase64Encoded": false,
            "headers": {},
            "body": JSON.stringify({"message": 'User not found'}),
        }
    }

     else if (resultCreator == "err"){
        return {
            "statusCode": 404,
            "isBase64Encoded": false,
            "headers": {},
            "body": JSON.stringify({"message": 'User not found'}),
        }
    }
    else{

        var c;
        for (c = 0; c<resultCreator.rows.length; c++){
            doc.push(resultCreator.rows[c].document)
        }

        var responseBody = {
            imgUserPath: resultUti.rows[0].image,
            username: resultUti.rows[0].username,
            name: resultUti.rows[0].name,
            surname: resultUti.rows[0].surname,
            xp: resultUti.rows[0].xp,
            bio: resultUti.rows[0].bio,
            university: resultUti.rows[0].university,
            faculty: resultUti.rows[0].faculty,
            documentUploaded: {
                num: doc.length,
                docs: doc
            },
            mashupCreated: {
                num: 0,
                docs: [
                ]
            }
        }

        var i;
        for (i=0; i< doc.length; i++){
            responseBody.documentUploaded.docs[i].uuid = doc[i];
        }
        var response = {
            statusCode: 200,
            isBase64Encoded: false,
            headers: {},
            body: JSON.stringify(responseBody)
        }
        doc = [];
        return response;
    }

}