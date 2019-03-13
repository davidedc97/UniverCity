const AmazonCognitoIdentity = require('amazon-cognito-identity-js');
const CognitoUserPool = AmazonCognitoIdentity.CognitoUserPool;
const AWS = require('aws-sdk');
global.fetch = require('node-fetch');

const poolData = {
    UserPoolId: "eu-west-2_TBU678aQA",
    ClientId: "dab8vgg9kq523eqel2jcka2e3"
};

const pool_region= "eu-west-2";

const userPool = new AmazonCognitoIdentity.CognitoUserPool(poolData);

function getOtherData(username){
    return new Promise((resolve, reject) => {

        var userData = {
            Username: username,
            Pool: userPool
        }

        var cognitoUser = new AmazonCognitoIdentity.CognitoUser(userData);
        cognitoUser.getUserAttribute({
            onFailure: function(err){
                result = {
                    "statusCode" : 400,
                    "body" : err.name
                };
                resolve(result);
            },
            onSucces: function(res){
                result = {
                    "statusCode" : 200,
                    "headers" : "",
                    "body" : {
                        "name" : res.name,
                        "surname" : res.surname,
                        "username" : res.username,
                        "message" : "ok"
                    }
                };
                resolve(result);
            },
        });
        return result;
    })
}

exports.handler = async (event, context, callback) => {
    var body = JSON.parse(event.body);
    
    var username = body.username;

    var response = {
        "statusCode": 200,
        "isBase64Encoded": false,
        "headers": {},
    }
    
    try{
        var result = await getOtherData(username).then((result) => {
            return result;
        });
        
        var statusCode = 200;
        var headers = {};
        var body = JSON.parse(result.body);
        if(JSON.parse(body.statusCode) === 400){
            statusCode = 400;
            headers = {};
            body = "Not Found"
        }
        
        response.statusCode = statusCode;
        response.headers = headers;
        response.body = body;
        
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
}

