aws dynamodb create-table \
    --table-name Students \
    --attribute-definitions \
        AttributeName=course_name,AttributeType=S \
        AttributeName=student_id,AttributeType=N \
    --key-schema \
        AttributeName=course_name,KeyType=HASH \
        AttributeName=student_id,KeyType=RANGE \
    --provisioned-throughput \
        ReadCapacityUnits=4,WriteCapacityUnits=2
