import boto3
from botocore.exceptions import NoCredentialsError, ClientError
import json

# Input variables
bucket_name = "s3-2024-s3929994"
source_ip = "0.0.0.0/0"
file_name = "s3929994.html"
region = "us-east-1"
account_id = "338084275222"

# Create a session and an S3 client
s3 = boto3.client('s3', region_name=region)

def create_bucket():
    try:
        # For us-east-1, do not specify the LocationConstraint
        if region == "us-east-1":
            s3.create_bucket(Bucket=bucket_name)
        else:
            s3.create_bucket(
                Bucket=bucket_name,
                CreateBucketConfiguration={'LocationConstraint': region}
            )
        print(f"Bucket '{bucket_name}' created successfully.")
    except ClientError as e:
        print(f"Error creating bucket: {e}")

def delete_public_access_block():
    try:
        # Delete the PublicAccessBlock configuration
        s3.delete_public_access_block(
            Bucket=bucket_name,
            ExpectedBucketOwner=account_id  # Provide your AWS account ID
        )
        print(f"Public access block configuration removed for '{bucket_name}'.")
    except ClientError as e:
        print(f"Error removing public access block: {e}")

def enable_static_website_hosting():
    try:
        # Enable static website hosting on the bucket
        s3.put_bucket_website(
            Bucket=bucket_name,
            WebsiteConfiguration={
                'IndexDocument': {
                    'Suffix': file_name
                },
                'ErrorDocument': {
                    'Key': 'error.html'
                }
            }
        )
        print(f"Static website hosting enabled on '{bucket_name}'.")
    except ClientError as e:
        print(f"Error enabling website hosting: {e}")

def apply_bucket_policy():
    # Define the policy that allows access from the specified IP
    policy = {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Principal": "*",
                "Action": "s3:GetObject",
                "Resource": f"arn:aws:s3:::{bucket_name}/*"
            },
            {
                "Effect": "Deny",
                "Principal": "*",
                "Action": "s3:GetObject",
                "Resource": f"arn:aws:s3:::{bucket_name}/*",
                "Condition": {
                    "IpAddress": {
                        "aws:SourceIp": source_ip
                    }
                }
            }
        ]
    }

    # Apply the policy to the bucket
    try:
        s3.put_bucket_policy(
            Bucket=bucket_name,
            Policy=json.dumps(policy)
        )
        print(f"Bucket policy applied to '{bucket_name}'.")
    except ClientError as e:
        print(f"Error applying policy: {e}")

def upload_file():
    try:
        # Upload the file to the S3 bucket
        s3.upload_file(file_name, bucket_name, file_name)
        print(f"File '{file_name}' uploaded to bucket '{bucket_name}'.")
    except FileNotFoundError:
        print(f"Error: The file '{file_name}' was not found.")
    except NoCredentialsError:
        print("Error: AWS credentials not found.")
    except ClientError as e:
        print(f"Error uploading file: {e}")

def main():
    create_bucket()
    upload_file()
    enable_static_website_hosting()
    delete_public_access_block()
    apply_bucket_policy()

if __name__ == "__main__":
    main()
