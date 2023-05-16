temp_region=$1
dyno_region="us-west-2"
echo "#######       Get all REST APIs On API Gateway with tag Ca: true for region ${temp_region}        #######"
rest_list=`aws apigateway get-rest-apis --region $temp_region --query "items[?tags.Ca=='true'].id[]" --output text`
echo
echo "${rest_list}"
echo
echo

echo "##########################        Get the current CA in ${temp_region}          ##########################"
prev_cert=`aws apigateway get-client-certificates --region $temp_region --query "items[?tags.cca=='true'].clientCertificateId[]" --output text`
echo
echo "${prev_cert}"
echo
echo
echo "##########################        Generate a new CA in ${temp_region}          ##########################"
echo

new_cert=`aws apigateway generate-client-certificate --description 'new certificate' --tags cca=true --region $temp_region --query "clientCertificateId"`
