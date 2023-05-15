import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import {
  DynamoDBDocumentClient,
  GetItemCommand
} from "@aws-sdk/lib-dynamodb";

const client = new DynamoDBClient({});

const dynamo = DynamoDBDocumentClient.from(client);

const tableName = "certs";

export const handler = async (event, context) => {
  let body;
  let statusCode = 200;
  const headers = {
    "Content-Type": "application/json",
  };
  
  try {
    switch (event.routeKey) {
      case "GET /api/{reg}": // one certificate per region
      
        const params = {
          TableName: tableName, //TABLE_NAME
          Key: {
            api: { S: event.pathParameters.reg },
          }
        };
        
        body = await dynamo.send(
          new GetItemCommand(params));
        body =body.Items.certi.S;
        break;
        
      default:
        throw new Error(`Unsupported route: "${event.routeKey}"`);
    }
  } catch (err) {
    statusCode = 400;
    body = err.message;
  } finally {
    body = JSON.stringify(body);
  }

  return {
    statusCode,
    body,
    headers,
  };
};