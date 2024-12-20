deployment_id=$(aws apigateway create-deployment \
  --rest-api-id "$api_id" \
  --stage-name dev \
  --stage-description "my dev stage" \
  --description "my dev deployment" \
  --region us-east-1 \
  --query "id" \
  --output text)

curl -X POST "$invoke_url" \
  -H "Content-Type: application/json" \
  -d '{
    "student_id": "S3929994",
    "given_name": "Khang",
    "family_name": "Nguyen"
  }'
