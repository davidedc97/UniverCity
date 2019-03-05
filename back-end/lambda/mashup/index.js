var AWS = require('aws-sdk');
var uuidv1 = require('uuid/v1');

var dynamodb = new AWS.DynamoDB();
var docClient = new AWS.DynamoDB.DocumentClient();

const checkPage = function(page){
    return new Promise(function(resolve,reject){
      var params = {
        Key: {
         "ID": {
           S: page
         }
        },
        TableName: "Pages"
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

const putDocument = function(id,title,creator,type,pages) {
    return new Promise(function(resolve,reject){
  
      var new_doc = {
        TableName: "Documents",
        Item: {
          "ID": id,
          "Title": title,
          "Creator": creator,
          "Type": type,
          "Pages": pages
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

exports.handler = async (event,context,callback) => {
    // TODO implement
    //event.params.querystring
    //event.username
    var title = "telecomunicazioni"
    var pages = ["abcdef"]
    var type = "M"
    var creator = "aldo"

    /*const response = {
        statusCode: 200,
        body: event.username,
    };*/

    var promises = []
    for(let page of pages){
      promises.push(checkPage(page));
    }

    //Check if all the pages exist
    try{
    var res = await Promise.all(promises).then(() => {
        console.log("[*] All the pages exist..continuing");
        var id = uuidv1();
        return putDocument(id,title,creator,type,pages);
    }).then((id) => {
        console.log("[*] A new mashup has been inserted")
        //res.status(201).send({"id":id,"type":"M"});
        const response = {
            statusCode: 200,
            body: {"id":id,"type":"M"},
        };
        return response
    }).catch((err) => {
        if(err) return {statusCode: 500,body: err};
        else return {statusCode: 409,body:"One or more pages don't exist"};
    })

    callback(null,res)
    }
    catch(e){
        callback(null,{statusCode: 500,body: "err"});
    }

    
};
