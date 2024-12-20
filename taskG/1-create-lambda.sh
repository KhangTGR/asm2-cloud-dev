zip AUDExchangeFunction.zip AUDExchangeFunction.py

aws lambda create-function \
    --function-name s3929994-AUDExchange \
    --runtime python3.8 \
    --role arn:aws:iam::$(aws sts get-caller-identity --query Account --output text):role/LabRole \
    --handler AUDExchangeFunction.lambda_handler \
    --zip-file fileb://AUDExchangeFunction.zip \
    --region us-east-1 \
    --memory-size 512 \
    --timeout 180 \
    --tags student_id=s3929994,course_name="Cloud Developing",student_id_and_course_name="s3929994_COSC2822" \
    --description "Cloud Developing A2 lambda function" 

aws lambda invoke --function-name s3929994-AUDExchange --cli-binary-format raw-in-base64-out --payload '{"currency": "USD", "amount": 100}' response-1.json
aws lambda invoke --function-name s3929994-AUDExchange --cli-binary-format raw-in-base64-out --payload '{"currency": "XYZ", "amount": 100}' response-2.json
aws lambda invoke --function-name s3929994-AUDExchange --cli-binary-format raw-in-base64-out --payload '{"currency": "USD", "amount": -1}' response-3.json
