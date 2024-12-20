import json

def lambda_handler(event, context):
    print("Received event:", json.dumps(event))
    
    body = json.loads(event['body'])
    
    student_id = body.get("student_id", "")
    given_name = body.get("given_name", "")
    family_name = body.get("family_name", "")
    
    student_id_full_name = f"{student_id}_{given_name}_{family_name}"
    
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json"
        },
        "body": json.dumps({
            "student_id_full_name": student_id_full_name,
            "StatusCode": 200,
            "version": 2
        })
    }
