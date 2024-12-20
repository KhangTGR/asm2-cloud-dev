api_id=$(aws apigateway create-rest-api \
  --name "s3929994-rest-api" \
  --description "My First Rest API" \
  --region us-east-1 \
  --query "id" \
  --output text)
