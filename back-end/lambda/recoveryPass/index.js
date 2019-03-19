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

function resetPassword(username, newPass, verificationCode) {

    cognitoUser = new AWSCognito.CognitoUser({
        Username: username,
        Pool: userPool
    });

    cognitoUser.forgotPassword({
        onSuccess: function(result) {
            console.log("OK zi");
            resolve(0);
        },
        onFailure: function(err) {
            console.log("eh no porcodio");
            reject(err);
        },
        inputVerificationCode() { 
            cognitoUser.confirmPassword(verificationCode, newPass, this);
        }
    });
}
 
function confirmPassword(username, verificationCode, newPassword) {
    cognitoUser = new AWSCognito.CognitoUser({
        Username: username,
        Pool: userPool
    });

    return new Promise((resolve, reject) => {
        cognitoUser.confirmPassword(verificationCode, newPassword, {
            onFailure(err) {
                reject(err);
            },
            onSuccess() {
                resolve();
            },
        });
    });
}

exports.handler = async (event, context, callback) => {
    var body = JSON.parse(event.body);
    
    var username = body.username;
    var oldPass = body.oldPass;

    var response = {
        "statusCode": 200,
        "isBase64Encoded": false,
        "headers": {},
    }
    
    //callback(null,response)
    
    try{
        var token = await resetPassword(username,pass).then((token) => {
            return token;
        });
        
        var statusCode = 200;
        var headers = {token: token}
        var body = "Authorized"
        if(token === "err"){
            statusCode = 403;
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