aws dynamodb update-table \
    --table-name Students \
    --attribute-definitions \
        AttributeName=course_year,AttributeType=N \
        AttributeName=course_name,AttributeType=S \
    --global-secondary-index-updates \
        "[{
            \"Create\": {
                \"IndexName\": \"CourseYearIndex\",
                \"KeySchema\": [
                    {\"AttributeName\": \"course_year\", \"KeyType\": \"HASH\"},
                    {\"AttributeName\": \"course_name\", \"KeyType\": \"RANGE\"}
                ],
                \"Projection\": {\"ProjectionType\": \"ALL\"},
                \"ProvisionedThroughput\": {
                    \"ReadCapacityUnits\": 4,
                    \"WriteCapacityUnits\": 2
                }
            }
        }]"

# query
aws dynamodb query \
    --table-name Students \
    --index-name CourseYearIndex \
    --key-condition-expression "course_year = :year" \
    --expression-attribute-values '{":year": {"N": "2023"}}'
