var express = require("express");
var bodyParser = require("body-parser");
var uuidv1 = require('uuid/v1');
var app = express();

app.use(bodyParser.urlencoded({
  extended: true
}));

app.use(bodyParser.json());

app.use(express.static(__dirname));

PORT = 8888;

const {DEBUG} = process.env;
const {DYNAMO_ENDPOINT} = process.env;

var AWS = require("aws-sdk");

AWS.config.update({
  region: "us-west-2",
  endpoint: DYNAMO_ENDPOINT
});

var dynamodb = new AWS.DynamoDB();
var docClient = new AWS.DynamoDB.DocumentClient();


/*****************************************************************************
 * TESTING AREA 
 *****************************************************************************/

//I want to verify if the tables exist
var retrieveTables = function() {
  return new Promise(function(resolve,reject) {
    dynamodb.listTables({}, function(err, data) {
      if (err) {
        console.error("[*] Unable to list table. Error JSON:", JSON.stringify(err, null, 2));
        reject();
      } else {
        resolve(data.TableNames);
      }
    });
  });
};

var checkTables = function(data) {
  return new Promise(function(resolve,reject) {
    if(data.includes("documents") && data.includes("pages") && data.includes("users")) resolve();
    else reject(data);
  });
};

//################################################################################

//curl -X POST 127.0.0.1/user -d {id:1,universita:sapienza,facolta=ingegneria,corso=informatica}  

//POST /user --data = { ID_UTENTE, universita, facolta, corso }
app.post("/user", function(req,res){
  if(req.body.id && req.body.universita && req.body.facolta && req.body.corso){
    //TO DO
    //Implement the user authentication (with the cookie)

    //PARAMS
    //Now I assume that, when the user signs up, the client sends a request both to the account server
    //and this server.
    //It could be better if the account server sends the request

    var id = req.body.id;
    var universita = req.body.universita;
    var facolta = req.body.facolta;
    var corso = req.body.corso;

    if(DEBUG) console.log("[*] Request: (" + id + ", " + universita + ", " + facolta + ", " + corso + ")");

    //"id=1&universita=sapienza&facolta=ingegneria&corso=bd"

    var params = {
      TableName: "users",
      Item: {
        "ID": {
          S: id
        },
        "universita": {
          S: universita
        }, 
        "facolta": {
          S: facolta
        }, 
        "corso": {
          S: corso
        }
      },
      ConditionExpression: 'attribute_not_exists(ID)',
      ReturnValues: 'ALL_OLD'
    };

    dynamodb.putItem(params, function(err, data) {
      if (err && err.code === "ConditionalCheckFailedException"){
        console.log("[*] User already exists");
        res.status(500).send("User already exists");
      }
      else if(err){
        console.log("[*] " + err, err.stack);
        res.status(500).send("Error");
      }
      else{
        if(DEBUG) console.log("[*] A user signed up: " + id);
        res.status(200).send("ok");
      }
    });
  }
  else{
    res.status(400).send("Bad parameter");
  }
});

//################################################################################

//DEBUG
//GET /user --data={ID}
//Return data o the specified user

app.get("/user", function(req,res){
  if(req.query.id){
    var id = req.query.id;

    var params = {
      Key: {
        "ID": {
           S: id
        }
      },
      TableName: "users"
    };

    dynamodb.getItem(params, function(err, data) {
      if (err){
        console.log(err, err.stack);
        res.status(500).send("Error");
      }
      else if(!data.Item){
        console.log("[*] User not found");
        res.status(404).send("User not found");
      }
      else{
        console.log("[*] User: " + JSON.stringify(data));
        res.status(200).send(data);
      }
    });
  }
  else{
    res.status(400).send("Bad parameter");
  }

});

//################################################################################

//AUX FUNCTIONS

const putPage = function(hash,user_id){
  return new Promise(function(resolve,reject) {

    var new_page = {
      TableName: "pages",
      Item: {
        "ID": hash,
        "owner": user_id,
        "likes": 0,
        "views": 0
      },
      ConditionExpression: 'attribute_not_exists(ID)',
    }

    //Insert the page in the db
    docClient.put(new_page, function(err, data) {
      if (err && err.code === "ConditionalCheckFailedException"){
        resolve(1);
      }
      else if(err){
        console.log(err);
        reject();
      }
      else{
        resolve(0);
      }
    });
  });
}

const putDocument = function(id,creator,type,pages,len) {
  return new Promise(function(resolve,reject){

    var new_doc = {
      TableName: "documents",
      Item: {
        "ID": id,
        "creator": creator,
        "type": type,
        "numpages": len,
        "tags": {},
        "likes": 0, 
        "downloads": 0,
        "pages": pages
      },
      ConditionExpression: 'attribute_not_exists(ID)',
      ReturnValues: 'ALL_OLD'
    };
  
  
    //Insert the document in the db
    docClient.put(new_doc, function(err, data) {
      if (err){
        console.log(err,err.stack);
        reject();
      }
      else{
        resolve(id);
      }
    });

  });
} 

//################################################################################

const checkUser = function(creator){
  return new Promise(function(resolve,reject){

    var params = {
      Key: {
       "ID": {
         S: creator
       }
      },
      TableName: "users"
    };
  
    dynamodb.getItem(params, function(err, data) {
      if (err){
        console.log(err, err.stack);
        reject(err);
      }
      else if(!data.Item){
        reject("User doesn't exist");
      }
      else{
        resolve();
      }
    });
  });
}

//POST /original --data = { ID_UTENTE, type, pages, len, tags = { materia, professore } }
app.post("/original",function(req,res){
  console.log("[*] Receiving a request");
  if(req.body.creator && req.body.type && req.body.pages){
    var creator = req.body.creator;
    var type = req.body.type;
    var pages = req.body.pages;
    var len = pages.length;

    var promises = [];

    for(var i=0; i < len; i++){
      promises.push(putPage(pages[i],creator));
    }

    //First the creator has to be an existing user
    //Insert the pages in the db. If one already exists it's a mash-up
    checkUser(creator).then(() =>{
      console.log("[*] User exists...continuing");
      return Promise.all(promises)
    }).then((values) => {
      console.log("[*] All pages have been inserted...continuing");
      if(values.includes(1)) type = "M";
      var id = uuidv1();
      return putDocument(id,creator,type,pages,parseInt(len));
    })
    //The document has been inserted
    .then((id) => {
      console.log("[*] The document has been inserted...continuing");
      res.status(201).send({"id":id,"type":type});
    })
    .catch((err) => {
      console.log("[*] " + err);
      res.status(500).send();
    })
    .catch((err) => {
      console.log("[*] " + err);
      res.status(500).send();
    })
    .catch((err) => {
      console.log("[*] Error: " + err);
      if(err === "User doesn't exist"){
        res.status(400).send("User doesn't exist");
      }
      else{
        res.status(500).send();
      }
    });
    

  }
  else{
    res.status(400).send("Bad parameter");
  }
});



//################################################################################

//Check is a page exists
const checkPage = function(page){
  return new Promise(function(resolve,reject){
    var params = {
      Key: {
       "ID": {
         S: page
       }
      },
      TableName: "pages"
    };
  
    dynamodb.getItem(params, function(err, data) {
      if (err){
        console.log(err, err.stack);
        reject(err);
      }
      else if(!data.Item){
        reject();
      }
      else{
        resolve();
      }
    });

  });
}


//POST /mashup --data = { ID_UTENTE, pages (list of IDs),, tags = { materia, professore } }
//This request is done by the docsServer. When a user uploads a new document (which is not a mash-up)
//the docsServer checks if all the pages are not already in the DB.

app.post("/mashup", function(req,res){
  console.log("[*] Receiving a request");
  if(req.body.creator && req.body.pages){
    //When a new document is created it has these values:
    //                - # likes = 0
    //                - # downloads = 0
    //                - materia = materia
    //                - professore = professore
    //                - type = "M"
    //                - pages = pages
    //                - creator = ID_UTENTE
    var creator    = req.body.creator;
    var type       = "M";
    var pages      = req.body.pages;
    var len        = pages.length;
    var id         = uuidv1();


    var promises = []
    for(let page of pages){
      promises.push(checkPage(page));
    }

    //Check if the pages exist
    Promise.all(promises).then(() => {
      console.log("[*] All the pages exist..continuing")
      return putDocument(id,creator,type,pages,len);
    }).then(() => {
      console.log("[*] A new mashup has been inserted")
      res.status(201).send({"id":id,"type":"M"});
    }).catch((err) => {
      if(err) res.status(500).send(err);
      else res.status(409).send("One or more pages don't exist");
    })

  }
  else{
    res.status(400).send("Bad parameter")
  }
});

//################################################################################

const putlike = function(user,id,table){
  return new Promise(function(resolve,reject){

    var new_like = {
      TableName: "like",
      Item: {
        "ID": user + id,
        "user": user,
        "item": id,
      },
      ConditionExpression: 'attribute_not_exists(ID)',
      ReturnValues: 'ALL_OLD'
    };
  
  
    //Insert the document in the db
    docClient.put(new_like, function(err, data) {
      if(err && err.code === "ConditionalCheckFailedException"){
        reject("Like already given");
      }
      else if (err){
        console.log(err,err.stack);
        reject(err);
      }
      else{
        resolve(id);
      }
    });
  });
}

const updateItem = function(id,table){
  return new Promise(function(resolve,reject){

    var doc_updated = {
      TableName:table,
      Key:{
          "ID": id,
      },
      UpdateExpression: "set likes += :one",
      ExpressionAttributeValues:{
          ":one": 1,
      },
      ReturnValues:"UPDATED_NEW"
    };
  
  
    //Insert the document in the db
    docClient.update(doc_updated, function(err, data) {
      if (err){
        console.log(err,err.stack);
        reject();
      }
      else{
        resolve(id);
      }
    });
  });
}

app.post("/like",function(req,res){
  //table = 0 => pages; table = 1 => documents
  if(req.body.user && req.body.id && req.body.table){
    var table = req.body.table;
    var user = req.body.user;
    var id = req.body.id;
    if(table === 0) table = "pages";
    else if(table === 1) table = "documents";
    else return res.status(400).send("Bad parameter");

    putlike(user,id,table).then(() => {
      return updateItem(id,table);
    }).then((data) => {
      res.status(201).send();
    }).catch((err) => {
      if(err === "Like already given") res.status(409).send("Like already given");
      else res.status(500).send("Error");
    });

  }
  else{
    res.status(400).send("Bad parameter")
  }
});

//################################################################################

const checkIfLike = function(user,id,table){
  return new Promise(function(resolve,reject){

    var params = {
      TableName : table,
      Key: {
        "ID": user + id
      }
    };
  
  
    //Insert the document in the db
    docClient.get(params, function(err, data) {
      if(err){
        reject();
      }
      else if (!data.Item){
        resolve(false);
      }
      else{
        resolve(true);
      }
    });
  });
}

const getLikes = function(id,table,prec){
  return new Promise(function(resolve,reject){

    var params = {
      TableName:table,
      Key:{
          "ID": id,
      },
      AttributesToGet: [
        'likes',
      ],
    };
  
  
    //Insert the document in the db
    docClient.get(params, function(err, data) {
      if (err){
        console.log(err,err.stack);
        reject();
      }
      else{
        resolve([data.Item.likes,prec]);
      }
    });
  });
}

//Return all the likes for a document or page and if the user liked it
app.get("/like",function(req,res){
  //table = 0 => pages; table = 1 => documents
  if(req.query.user && req.query.id && req.query.table){
    var table = req.query.table;
    var user = req.query.user;
    var id = req.query.id;
    if(table === 0) table = "pages";
    else if(table === 1) table = "documents";
    else return res.status(400).send("Bad parameter");

    checkIfLike(user,id,table).then((data) => {
      return updateItem(id,table);
    }).then((data) => {
      res.status(200).send({"n":data[0],"liked":data[1]});
    }).catch((err) => {
      res.status(500).send("Error");
    });

  }
  else{
    res.status(400).send("Bad parameter")
  }
});

//################################################################################


retrieveTables().then(function(data){
  return checkTables(data);
}).then(function() {
  console.log("Tables are ok. Starting...");
  app.listen(PORT, function(){
    console.log("[*] Server listening on port " + PORT);
  });
}).catch(function(data){
  console.log("[*] Error! The tables are " + JSON.stringify(data) + ", they should be " + JSON.stringify(["documents","pages","users"]));
});