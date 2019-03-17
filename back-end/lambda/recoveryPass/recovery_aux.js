
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

function confirmPassword(username, verCode, newPassword) {

    cognitoUser = new AWSCognito.CognitoUser({
        Username: username,
        Pool: userPool
    });

    return new Promise((resolve, reject) => {
        cognitoUser.confirmPassword(verCode, newPassword, {
            onFailure(err) {
                resolve("err");
            },
            onSuccess() {
                resolve(0);
            },
        });
    });
}

exports.handler = async (event, context, callback) => {
    var body = JSON.parse(event.body);
    
    var username = body.username;
    var verCode = body.verCode;
    var newPass = body.newPass;

    var response = {
        "statusCode": 200,
        "isBase64Encoded": false,
        "headers": {},
    }
    
    //callback(null,response)
    
    try{
        var control = await confirmPassword(username,verCode,newPass).then((control) => {
            return control;
        });
        
        var statusCode = 200;
        var headers = {}
        var body = "Authorized"
        if(control === "err"){
            statusCode = 400;
            headers = {};
            body = "Not Authorized"
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