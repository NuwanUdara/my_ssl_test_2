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
sleep 5
echo
echo "##########################        Get the current CAs in ${temp_region}          ##########################"
prev_cert=`aws apigateway get-client-certificates --region $temp_region --query "items[?tags.cca=='true'].clientCertificateId[]" --output text`

daddas
