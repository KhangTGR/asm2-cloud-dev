# TASK A
## Create image
docker rm -f s3929994
docker build -t s3929994 .
docker run -d -p 5000:80 --name s3929994 s3929994

## Create ECR
aws ecr create-repository --repository-name "asm-registry" --region ap-southeast-1 --profile renovalab

## Push image
aws ecr get-login-password --region ap-southeast-1 --profile renovalab | docker login --username AWS --password-stdin $(aws sts get-caller-identity --query Account --output text --profile renovalab).dkr.ecr.ap-southeast-1.amazonaws.com
docker tag s3929994:latest $(aws sts get-caller-identity --query Account --output text --profile renovalab).dkr.ecr.ap-southeast-1.amazonaws.com:latest
docker push $(aws sts get-caller-identity --query Account --output text --profile renovalab).dkr.ecr.ap-southeast-1.amazonaws.com:latest

# TASK B
## Create bucket
aws s3api create-bucket --bucket asm-bucket-test --region ap-southeast-1 --profile renovalab --create-bucket-configuration LocationConstraint=ap-southeast-1

## Enable static web
aws s3 website s3://asm-bucket-test/ --index-document s3929994.html --profile renovalab
aws s3 cp s3929994.html s3://asm-bucket-test/ --profile renovalab

aws s3api put-public-access-block --bucket asm-bucket-test --public-access-block-configuration \
'{"BlockPublicAcls": false, "IgnorePublicAcls": false, "BlockPublicPolicy": false, "RestrictPublicBuckets": false}' --profile renovalab

## Set policy
cat > bucket-policy.json <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowGetObjectForUser",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::asm-bucket-test/*"
        },
        {
            "Sid": "AllowIPAccessOnly",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::asm-bucket-test/*",
            "Condition": {
                "NotIpAddress": {
                    "aws:SourceIp": "..."
                }
            }
        }
    ]
}
EOF
aws s3api put-bucket-policy --bucket asm-bucket-test --policy file://bucket-policy.json --profile renovalab

## Try
curl http://asm-bucket-test.s3-website-ap-southeast-1.amazonaws.com

## Get pre-signed URL
aws s3 presign s3://asm-bucket-test/s3929994.html --expires-in 60 --profile renovalab

## Try pre-signed URL
curl "$(aws s3 presign s3://asm-bucket-test/s3929994.html --expires-in 60 --profile renovalab)"

# TASK C
## Zip source
zip lambda_function.zip lambda_function_v1.py

aws lambda create-function \
    --function-name asm-function \
    --runtime python3.8 \
    --role arn:aws:iam::$(aws sts get-caller-identity --query Account --output text --profile renovalab):role/asm-LabRole \
    --handler lambda_function.lambda_handler \
    --zip-file fileb://lambda_function.zip \
    --memory-size 512 \
    --timeout 180 \
    --tags student_id=s3929994,course_name="Cloud Developing" \
    --description "Cloud Developing A2 lambda function" \
    --profile renovalab

## Update function
zip lambda_function.zip lambda_function_v2.py

aws lambda update-function-code \
    --function-name asm-function \
    --zip-file fileb://lambda_function.zip \
    --publish \
    --profile renovalab

aws lambda create-alias \
    --function-name asm-function \
    --name dev \
    --function-version "$(
        aws lambda list-versions-by-function \
            --function-name asm-function \
            --query 'Versions[?Version!=`$LATEST`].Version' \
            --output text \
            --profile renovalab
    )" \
    --profile renovalab

aws lambda invoke \
    --function-name asm-function:dev \
    --cli-binary-format raw-in-base64-out \
    --payload '{"student_id": "s3929994", "given_name": "Khang","family_name": "Trong Nguyen"}' \
    --profile renovalab \
    responses/sync_response.json

aws lambda invoke \
    --function-name asm-function:dev \
    --cli-binary-format raw-in-base64-out \
    --invocation-type Event \
    --payload '{"student_id": "s3929994", "given_name": "Khang","family_name": "Trong Nguyen"}' \
    --profile renovalab \
    responses/async_response.json
