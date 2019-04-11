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

async function getDocMetadata(id){
    return await psql.query("SELECT * from document where id = $1", [id])
};

exports.handler = async (event) => {
    
    var id = event.queryStringParameters.uuid;
    var result = await getDocMetadata(id)

    if (result == 'err'){
        return {
            "statusCode": 404,
            "isBase64Encoded": false,
            "headers": {},
            "body": JSON.stringify({"message": 'Doc not found'}),
        }
    }
    else {
        
        var responseBody = {
            "uuid": result.rows[0].id,
            "title": result.rows[0].title,
            "type": result.rows[0].flag,
            "creator": result.rows[0].creator
        }
    
        return {
            "statusCode": 200,
            "isBase64Encoded": false,
            "headers": {},
            "body": JSON.stringify(responseBody),
        }
        
    }
}

