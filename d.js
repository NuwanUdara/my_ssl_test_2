const { GetItemCommand} = require("@aws-sdk/client-dynamodb");
const ddbClient  = require( "./dbb.js");
let Table = process.env.CERT_TABLE | "certs"
const REGION = process.env.API_REGION | "us-west-2";
// Set the parameters
const params = {
  TableName: Table, //TABLE_NAME
  Key: {
    api: { S: REGION },
  }
};

async function run () {
  let data = await ddbClient.send(new GetItemCommand(params));
  data = data.Item.cert.S
  //console.log(data)
  // console.log("Success", data.Item.certi.S);
  return data
};
module.exports = run;
