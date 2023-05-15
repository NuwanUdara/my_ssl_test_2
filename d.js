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
  const data = await ddbClient.send(new GetItemCommand(params));
  console.log("Success", data.Item);
  return data;
  
};
module.exports = run;

