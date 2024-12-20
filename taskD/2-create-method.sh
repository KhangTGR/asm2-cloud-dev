root_resource_id=$(aws apigateway get-resources \
  --rest-api-id "$api_id" \
  --region us-east-1 \
  --query "items[0].id" \
  --output text)

aws apigateway put-method \
  --rest-api-id "$api_id" \
  --resource-id "$root_resource_id" \
  --http-method POST \
  --authorization-type NONE \
  --region us-east-1
