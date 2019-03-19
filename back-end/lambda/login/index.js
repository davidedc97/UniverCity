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

function SignIn(username,pass){
    return new Promise((resolve,reject) => {
        var autenticationValue = new AmazonCognitoIdentity.AuthenticationDetails({
            Username: username,
            Password: pass
        })

        var userData = {
            Username: username,
            Pool: userPool
        }
    
        var cognitoUser = new AmazonCognitoIdentity.CognitoUser(userData);
        cognitoUser.authenticateUser(autenticationValue, {
            onSuccess: function(response) {
                var token = response.getIdToken().getJwtToken();
                console.log("[*] Token nuovo: " + token);
                resolve(token);
            },
            onFailure: function(err) {
                console.log("[*] Errore nuovo: " + JSON.stringify(err))
                resolve("err");
            },
        });
    });
}


exports.handler = async (event, context, callback) => {
    var body = JSON.parse(event.body);
    
    var username = body.username;
    var pass = body.pass;

    var response = {
        "statusCode": 200,
        "isBase64Encoded": false,
        "headers": {},
    }
    
    //callback(null,response)
    
    try{
        var token = await SignIn(username,pass).then((token) => {
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
    
    
    /*var token = SignIn(username,pass);
    console.log("[*] Altro " + token);
    callback(null,"ok")*/
};

