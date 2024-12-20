aws sns publish \
  --topic-arn "$SNS_TOPIC_ARN" \
  --message "Hello from s3929994 - this is message 1!" \
  --region us-east-1

# check the monitoring results
aws logs describe-log-groups --log-group-name-prefix "/aws/lambda/s3929994-function1" --region us-east-1
aws logs describe-log-groups --log-group-name-prefix "/aws/lambda/s3929994-function2" --region us-east-1

# view the logs from the execution
aws logs get-log-events --log-group-name "/aws/lambda/s3929994-function1" --log-stream-name '2024/12/20/[$LATEST]c7810ea68d4341b994ace02f4f4244a4' --region us-east-1
aws logs get-log-events --log-group-name "/aws/lambda/s3929994-function2" --log-stream-name '2024/12/20/[$LATEST]a59873f9ccb047389bf23d49607cc2f5' --region us-east-1
