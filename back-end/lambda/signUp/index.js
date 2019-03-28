const AmazonCognitoIdentity = require('amazon-cognito-identity-js');
const CognitoUserPool = AmazonCognitoIdentity.CognitoUserPool;
const AWS = require('aws-sdk');
global.fetch = require('node-fetch');
var Pool = require('pg').Pool;

const poolData = {
    UserPoolId: "eu-west-2_TBU678aQA",
    ClientId: "dab8vgg9kq523eqel2jcka2e3"
};

const userPool = new AmazonCognitoIdentity.CognitoUserPool(poolData);

const psql = new Pool ({
    host: 'metadata.czzhwg1jheui.eu-west-1.rds.amazonaws.com',
    user: 'univercity',
    password: '',
    database: 'metadata',
    port: 5432
})

function SignUp(username,pass,name,surname,email,faculty,university){
    return new Promise((resolve,reject) => {

        var attList = [];
        //attList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "id", Value: id}));
        attList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "name", Value: name}));
        attList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "custom:surname", Value: surname}));
        attList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "email", Value: email}));
        attList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "custom:faculty", Value: faculty}));
        attList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "custom:university", Value: university}));
        //attList.push(new AmazonCognitoIdentity.CognitoUserAttribute({Name: "preferred_username", Value: username}));

        userPool.signUp(username, pass, attList, null, function(err, res){
            if(err){
                console.log("[*] Errore: " + JSON.stringify(err))
                reject(err);
                return;
            }

            psql.query("INSERT INTO utilitator VALUE ($1, $2, $3, $4, $5)", [faculty,university,username,name,surname]);
            var cognitoUser = res.user;
            var user = cognitoUser.getUsername();
            console.log("[*] User: " + cognitoUser);
            resolve(user);
        })
    })
}

exports.handler = async (event, context, callback) => {
    /*var username = "giacomino";
    var pass = "Giovanni1-";
    var name = "Giacomo";
    var surname = "Poretti";
    var email = "giacomo@poretti.it";
    var university = "Sapienza";
    var faculty = "Lettere";*/
    
    var body = JSON.parse(event.body);
    
    var username = body.username;
    var pass = body.pass;
    var name = body.name;
    var surname = body.surname;
    var email = body.email;
    var university = body.university;
    var faculty = body.faculty;
    
    var response = {
        "isBase64Encoded": false,
        "headers": {},
    }
    
    try {
        await SignUp(username,pass,name,surname,email,faculty,university).then((user) =>{
            response.statusCode = 200;
            response.body = user;
        }).catch((err) => {
            response.statusCode = 409;
            response.body = JSON.stringify(err);
        });

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
};
