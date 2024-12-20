## Zip source
cp lambda_function_v1.py lambda_function.py
zip lambda_function.zip lambda_function.py

aws lambda create-function \
    --function-name s3929994-function \
    --runtime python3.8 \
    --role arn:aws:iam::$(aws sts get-caller-identity --query Account --output text):role/LabRole \
    --handler lambda_function.lambda_handler \
    --zip-file fileb://lambda_function.zip \
    --memory-size 512 \
    --timeout 180 \
    --tags student_id=s3929994,course_name="Cloud Developing",student_id_and_course_name="s3929994_COSC2822" \
    --description "Cloud Developing A2 lambda function" 

aws lambda invoke \
    --function-name s3929994-function \
    --cli-binary-format raw-in-base64-out \
    --payload '{"student_id":"s3929994","given_name":"Khang","family_name":"Nguyen Trong"}' \
    responses/v1_sync_response.json
