account_id=$(aws sts get-caller-identity --query Account --output text)

aws lambda create-function \
  --function-name "s3929994-function1" \
  --runtime python3.8 \
  --role arn:aws:iam::"'"$account_id"'":role/LabRole \
  --handler lambda_function.lambda_handler \
  --zip-file fileb://lambda_function.zip \
  --region us-east-1 \
    --memory-size 512 \
    --timeout 180 \
    --tags student_id=s3929994,course_name="Cloud Developing",student_id_and_course_name="s3929994_COSC2822" \
    --description "Cloud Developing A2 lambda function" 

aws lambda create-function \
  --function-name "s3929994-function2" \
  --runtime python3.8 \
  --role arn:aws:iam::"'"$account_id"'":role/LabRole \
  --handler lambda_function.lambda_handler \
  --zip-file fileb://lambda_function.zip \
  --region us-east-1 \
    --memory-size 512 \
    --timeout 180 \
    --tags student_id=s3929994,course_name="Cloud Developing",student_id_and_course_name="s3929994_COSC2822" \
    --description "Cloud Developing A2 lambda function" 

aws lambda create-event-source-mapping \
  --function-name "s3929994-function1" \
  --event-source-arn "$QUEUE1_ARN" \
  --batch-size 1 \
  --region us-east-1

aws lambda create-event-source-mapping \
  --function-name "s3929994-function2" \
  --event-source-arn "$QUEUE2_ARN" \
  --batch-size 1 \
  --region us-east-1

aws logs create-log-group --log-group-name "/aws/lambda/s3929994-function1" --region us-east-1
aws logs create-log-group --log-group-name "/aws/lambda/s3929994-function2" --region us-east-1
