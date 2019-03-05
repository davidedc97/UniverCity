
const AmazonCognitoIdentity = require('amazon-cognito-identity-js');
const CognitoUserPool = AmazonCognitoIdentity.CognitoUserPool;
const AWS = require('aws-sdk');
global.fetch = require('node-fetch');

var token = null;
var error = null;

const poolData = {
    UserPoolId: "eu-west-2_TBU678aQA",
    ClientId: "5scvltpq1nt3jdae3jf1o66jtm"
};

const pool_region= "eu-west-2";

const userPool = new AmazonCognitoIdentity.CognitoUserPool(poolData);

function SignIn(username,pass){
    var autenticationValue = new AmazonCognitoIdentity.AuthenticationDetails({
        Username: username,
        Password: pass
    })

    var userData = {
        Username: username,
        Pool: userPool,
        Data: poolData
    }
    
    var cognitoUser = new AmazonCognitoIdentity.CognitoUser(userData);
    cognitoUser.authenticateUser(autenticationValue, {
        onSuccess: function(res) {
            token = res.getAccessToken().getJwtToken();
        },
        onFailure: function(err) {
            error = err;
        },
    });

    //if (token != null && error == null) return token;
    //else if (token == null && error != null) return 0;
}


exports.handler = async (event, context, callback) => {
    var  username = "giovanni";
    var pass = "Giovanni1-";
    
    SignIn(username,pass);
    var response = {
        "statusCode": 200,
        "headers": {
            "token": token
        },
        "body": "ok",
        "isBase64Encoded": false
    };
    callback(null, response);
};
