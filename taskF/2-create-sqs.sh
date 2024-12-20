account_id=$(aws sts get-caller-identity --query Account --output text)

aws sqs create-queue --queue-name "s3929994-Queue1"
aws sqs create-queue --queue-name "s3929994-Queue2"

QUEUE1_URL=$(aws sqs get-queue-url --queue-name "s3929994-Queue1" --query "QueueUrl" --output text)
QUEUE1_ARN=$(aws sqs get-queue-attributes --queue-url "$QUEUE1_URL" --attribute-name QueueArn --query "Attributes.QueueArn" --output text)

QUEUE2_URL=$(aws sqs get-queue-url --queue-name "s3929994-Queue2" --query "QueueUrl" --output text)
QUEUE2_ARN=$(aws sqs get-queue-attributes --queue-url "$QUEUE2_URL" --attribute-name QueueArn --query "Attributes.QueueArn" --output text)

SNS_TOPIC_ARN=$(aws sns list-topics --query "Topics[?TopicArn=='arn:aws:sns:us-east-1:$account_id:s3929994-SNSTopic'].TopicArn" --output text)

aws sns subscribe --topic-arn "$SNS_TOPIC_ARN" --protocol sqs --notification-endpoint "$QUEUE1_ARN"
aws sns subscribe --topic-arn "$SNS_TOPIC_ARN" --protocol sqs --notification-endpoint "$QUEUE2_ARN"
