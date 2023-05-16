temp_region=$1
table_name=$2

dyno_region="us-west-2"

if [ "$1" == "-h" ] || [ -z "$1" ] || [ -z "$2" ] || [ "$1" == "help" ] || [ "$1" == "-help" ]; then
  echo "Usage: `basename $0`"
  echo "Options"
  echo "region             :- The region you need update the certificate to database"
  echo "Certificates table :- The Table Name"
  echo 'Example: ./dynomodb_update.sh us-west-2 certs'
  exit 0
fi

echo "###########################################################################################################"
echo "##                                                                                                       ##"
echo "##                               Upload the certicates to a DynamoDB                                     ##"
echo "##                                                                                                       ##"
echo "###########################################################################################################"
echo
echo
sleep 3
echo
echo "##########################        Get the current CAs in ${temp_region}          ##########################"
cert=`aws apigateway get-client-certificates --region $temp_region --query "items[?tags.cca=='true'].pemEncodedCertificate" --output text`

# Check if the table exists
if aws dynamodb describe-table --table-name $table_name --region $temp_region >/dev/null 2>&1; then
  echo "Table $table_name exists."
else
  echo "Table $table_name does not exist."
  echo "Please Create a table or, use the correct table name."
  exit 0 #success
fi

aws dynamodb put-item \
  --table-name "$table_name" \
  --region "$temp_region" \
  --item "{\"api\":{\"S\":\"$temp_region\"}, \"cert\":{\"S\":\"$attribute_value\"}}"