import boto3
import json
from botocore.exceptions import ClientError

# Initialize DynamoDB client
dynamodb = boto3.client('dynamodb')

# Load data from the JSON file
with open('3-students.json') as f:
    students_data = json.load(f)

# Insert data into DynamoDB
for student in students_data:
    try:
        response = dynamodb.put_item(
            TableName='Students',
            Item={
                'course_name': {'S': student['course_name']},
                'student_id': {'N': str(student['student_id'])},
                'student_email': {'S': student['student_email']},
                'student_name': {'S': student['student_name']},
                'course_year': {'N': str(student['course_year'])}
            },
            ConditionExpression="attribute_not_exists(course_name) AND attribute_not_exists(student_id)"
        )
        print(f"Inserted: {student['student_name']}")
    except ClientError as e:
        print(f"Failed to insert {student['student_name']}: {e.response['Error']['Message']}")
