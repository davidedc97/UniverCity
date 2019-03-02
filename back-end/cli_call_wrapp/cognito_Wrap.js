const express = require('express');
const app = express();

const bodyP = require("body-parser");
app.use(bodyP.urlencoded());

const AmazonCognitoIdentity = require('amazon-cognito-identity-js');
const CognitoUserPool = AmazonCognitoIdentity.CognitoUserPool;
const AWS = require('aws-sdk');
const request = require('request');
const jwkToPem = require('jwk-to-pem');
const jwt = require('jsonwebtoken');
const crypto = require('crypto');
global.fetch = require('node-fetch');

var username = null;
var name = null;
var surname = null;
var email = null;
var pass = null;
var faculty = null;
var university = null;
var token = null;
var error = null;

/*
** ########################
** # SERVER CONFIGURATION #
** ########################
*/

const poolData = {
    UserPoolId: "eu-west-2_TBU678aQA",
    ClientId: "5scvltpq1nt3jdae3jf1o66jtm"
};

const pool_region= "eu-west-2";

const userPool = new AmazonCognitoIdentity.CognitoUserPool(poolData);

/*
** ###################
** # CLIENT WRAPPING #
** ###################
**
*/

app.post("/user", function(req, res){
    username = req.body.username;
    name = req.body.name;
    surname = req.body.surname;
    email = req.body.email;
    pass = req.body.pass;
    faculty = req.body.faculty;
    university = req.body.university;
    
    var control = SignUp();

    if (control == null) res.sendStatus(400).statusMessage("User already exist");
    else {
        res.sendStatus(200);
    }
})

app.post("/user", function(req, res){
    username = req.body.username;
    pass = req.body.pass;

    var control = SignIn();

    if (control == 0) res.sendStatus(200);
    else {
        res.sendStatus(400);
    }
})

// getOtherUserById and getMyUserById MISSING

/*
** ########################
** # REGISTRATION PROCESS #
** ########################
*/

function SignUp(){

    var control;
    var pwd = username + Date();
    var id = crypto.createHash('sha256').update().digest;

    var attList = [];
    attList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "id", Value: id}));
    attList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "name", Value: name}));
    attList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "surname", Value: surname}));
    attList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "email", Value: email}));
    attList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "faculty", Value: faculty}));
    attList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "university", Value: university}));
    attList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "preferrred_username", Value: username}));

    userPool.signUp(username, pass, attList, null, function(err, res){
        if(err){
            return err.name;
        }
        var cognitoUser = res.user;
        control = cognitoUser.getUsername();
    })
    return control;
}

/*
** #################
** # LOGIN PROCESS #
** #################
*/

function SignIn(){
    var autenticationValue = new AmazonCognitoIdentity.AuthenticationDetails({
        Username: username,
        Password: pass
    })

    var userData = {
        Username: username,
        Pool: "user"
    }

    var cognitoUser = new AmazonCognitoIdentity.CognitoUser(userData);
    cognitoUser.authenticateUser(autenticationValue, {
        onSuccess: function(res) {
            token = res.getAccessToken();
        },
        onFailure: function(err) {
            error = err;
        },
    });

    if (token != null && error == null) return 0;
    else if (token == null && error != null) return 1;
}


