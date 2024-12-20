import boto3
from botocore.exceptions import ClientError
import json

# Input variables
bucket_name = "s3-2024-s3929994"
source_ip = "118.69.183.31/32"

# Create a session and an S3 client
s3 = boto3.client('s3')

def apply_bucket_policy():
    # Define the policy that allows access from the specified IP
    policy = {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
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

if __name__ == "__main__":
    apply_bucket_policy()
