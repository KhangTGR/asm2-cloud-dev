aws dynamodb put-item \
    --table-name Students \
    --item \
        '{"course_name": {"S": "Cloud Developing"}, "student_id": {"N": "1000001"}, "student_email": {"S": "s1000001@cloudexpert.edu.au"}, "student_name": {"S": "John Doe"}, "course_year": {"N": "2024"}}' \
    --condition-expression "attribute_not_exists(course_name) AND attribute_not_exists(student_id)"

# fail case
aws dynamodb put-item \
    --table-name Students \
    --item \
        '{"student_id": {"N": "1000001"}, "student_email": {"S": "s1000001@cloudexpert.edu.au"}, "student_name": {"S": "John Doe"}, "course_year": {"N": "2024"}}' \
    --condition-expression "attribute_not_exists(course_name) AND attribute_not_exists(student_id)"
