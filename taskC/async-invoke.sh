aws lambda invoke \
    --function-name s3929994-function:dev \
    --cli-binary-format raw-in-base64-out \
    --invocation-type Event \
    --payload '{"student_id": "s3929994", "given_name": "Khang","family_name": "Trong Nguyen"}' \
    responses/async_response.json
