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
cert=`aws apigateway get-client-certificates --region $temp_region --query "items[?tags.cca=='true'].pemEncodedCertificate" --output json` 
echo

dosed=`sed -e "s/\r//g" <<< $cert`
# echo $cert | less
echo $dosed | sed 's/[][]//g' | sed 's/ *$//'| sed 's/^ *//g' | sed -e 's/^"//' -e 's/"$//' > my.cert 
# echo $dosed | less
cert_data=`cat my.cert`
rm my.cert
# Check if the table exists
if aws dynamodb describe-table --table-name $table_name --region $temp_region >/dev/null 2>&1; then
  echo "Table $table_name exists."
  echo "Updateing the Certificate"
else
  echo "Table $table_name does not exist."
  echo "Please Create a table or, use the correct table name."
  exit 0 #success
fi
echo
echo "##############        Updating the certificate to the DynomoDB table ${table_name}          ##############"
aws dynamodb put-item --region $temp_region --table-name $table_name --item "{\"api\": {\"S\": \"$temp_region\"}, \"cert\": {\"S\": \"$cert_data\"} }"
echo "Done"

