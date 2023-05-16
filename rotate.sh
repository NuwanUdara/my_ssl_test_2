temp_region=$1
production_stage=$2
dyno_region="us-west-2"

if [ "$1" == "-h" ] || [ -z "$1" ] || [ -z "$2" ] || [ "$1" == "help" ] || [ "$1" == "-help" ]; then
  echo "Usage: `basename $0`"
  echo "Options"
  echo "region           :- The region you need to check rotate the Client Certificates"
  echo "production stage :- The name of the production stage your rest APIs run in"
  echo 'Example: ./rotate.sh us-west-2 Prod'
  exit 0
fi

echo "#######       Get all REST APIs On API Gateway with tag Ca: true for region ${temp_region}        #######"
rest_list=`aws apigateway get-rest-apis --region $temp_region --query "items[?tags.Ca=='true'].id[]" --output text`
echo
echo "${rest_list}"
echo "Done!"
echo
echo
echo "##########################        Get the current CA in ${temp_region}          ##########################"
prev_cert=`aws apigateway get-client-certificates --region $temp_region --query "items[?tags.cca=='true'].clientCertificateId[]" --output text`
echo
echo "${prev_cert}"
echo "Done!"
echo
echo "##########################        Generate a new CA in ${temp_region}          ##########################"
echo
echo
new_cert=`aws apigateway generate-client-certificate --description 'new certificate' --tags cca=true --region $temp_region --query "clientCertificateId"`
echo "Done!"
echo 
echo
echo "###################        Rotate The CA for All Rest APIs in ${temp_region}          ###################"
for val in $rest_list; do
 aws apigateway update-stage --rest-api-id $val --stage-name $production_stage --patch-operations '[{"op":"replace","path":"/clientCertificateId","value":'${new_cert}'}]' --region $temp_region --query "deploymentId"
 echo "Done!"
done
echo 
echo
echo "#####################        Remove the old CA in the region ${temp_region}          #####################"
echo
echo
for val in $prev_cert; do
 echo 'removing '${val}''
 aws apigateway delete-client-certificate --client-certificate-id $val --region $temp_region
 echo "Done!"
done
echo 
echo "#########################################################################################################"
