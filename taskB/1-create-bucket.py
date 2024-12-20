import boto3
from botocore.exceptions import ClientError

# Input variables
bucket_name = "s3-2024-s3929994"
region = "us-east-1"

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

if __name__ == "__main__":
    create_bucket()
