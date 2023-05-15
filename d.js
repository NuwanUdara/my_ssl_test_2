// Import required AWS SDK clients and commands for Node.js
// import { GetItemCommand } from "@aws-sdk/client-dynamodb";
// import { ddbClient } from "./dbb.js";
const { GetItemCommand} = require("@aws-sdk/client-dynamodb");
const ddbClient  = require( "./dbb.js");

// Set the parameters
const params = {
  TableName: "certs", //TABLE_NAME
  Key: {
    api: { S: "test1" },
  }
};

async function run () {
  let data = await ddbClient.send(new GetItemCommand(params));
  data = JSON.stringify(data.Item.certi.S)
  //console.log(data)
  // console.log("Success", data.Item.certi.S);
  if (data){
  return data;
  }
};
module.exports = run;
