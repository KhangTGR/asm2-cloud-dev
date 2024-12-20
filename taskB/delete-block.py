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

if __name__ == "__main__":
    delete_public_access_block()
    apply_bucket_policy()
