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
  data = data.Item.certi.S
  //console.log(data)
  // console.log("Success", data.Item.certi.S);
  return data
};
module.exports = run;
