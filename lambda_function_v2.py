def lambda_handler(event, context):
    # Extract event data
    student_id = event.get("student_id", "")
    given_name = event.get("given_name", "")
    family_name = event.get("family_name", "")
    
    # Concatenate values with spaces in between
    student_id_full_name = f"{student_id} {given_name} {family_name}"
    
    # Return the response as per the required format
    return {
        "student_id_full_name": student_id_full_name,
        "StatusCode": 200,
        "version": 2
    }
