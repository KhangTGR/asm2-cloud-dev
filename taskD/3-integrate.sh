aws apigateway put-integration \
  --rest-api-id "$api_id" \
  --resource-id "$root_resource_id" \
  --http-method POST \
  --type AWS_PROXY \
  --integration-http-method POST \
  --uri "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:$(aws sts get-caller-identity --query "Account" --output text):function:s3929994-function/invocations" \
  --region us-east-1

aws lambda add-permission \
  --function-name s3929994-function \
  --statement-id "APIGatewayInvokePermission" \
  --action "lambda:InvokeFunction" \
  --principal "apigateway.amazonaws.com" \
  --source-arn "arn:aws:execute-api:us-east-1:$(aws sts get-caller-identity --query "Account" --output text):$api_id/*/POST/" \
  --region us-east-1
