var AmazonCognitoIdentity = require('amazon-cognito-identity-js');
var CognitoUserPool = AmazonCognitoIdentity.CognitoUserPool;
var AWS = require('aws-sdk');
var request = require('request');
var jwkToPem = require('jwk-to-pem');
var jwt = require('jsonwebtoken');
global.fetch = require('node-fetch');

const poolData = {
    UserPoolId: "eu-west-2_TBU678aQA",
    ClientId: "<ClientAppId>"
};

const pool_region= "eu-west-2";

const userPool = new AmazonCognitoIdentity.CognitoUserPool(poolData);

/*
**  ########################
**  # REGISTRATION PROCESS #
**  ########################
*/

function SignUp(){
    var attList = [];
    attList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "name", Value: ""}));
    attList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "surname", Value: ""}));
    attList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "email", Value: ""}));
    attList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "faculty", Value: ""}));
    attList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "university", Value: ""}));
    attList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "preferrred_username", Value: ""}));

    userPool.signUp("<username>", "<pass>", attList, null, function(err, res){
        if(err){
            return err.name;
        }
        var cognitoUser = res.user;
        return cognitoUser.getUsername();
    })
}

// manca wrapping chiamate da client

/*
**  #################
**  # LOGIN PROCESS #
**  #################
*/

function SignIn(){
    var autenticationValue = new AmazonCognitoIdentity.AuthenticationDetails({
        Username: "<username/emai>",
        Password: "<pass>"
    })

    var userData = {
        Username: "<username/emai>",
        Pool: userPool
    }

    var cognitoUser = new AmazonCognitoIdentity.CognitoUser(userData);
    cognitoUser.authenticateUser(autenticationValue, {
        onSuccess: function(res) {
            console.log(res.getAccessToken().getJwtToken());
            console.log(res.getIdToken().getJwtToken());
            console.log(res.getRefreshToken().getJwtToken());
        },
        onFailure: function(err) {
            console.log(err);
        },
    });
}

// manca wrapping chiamate da client