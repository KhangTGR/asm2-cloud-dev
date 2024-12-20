import boto3
from botocore.exceptions import ClientError

# Input variables
bucket_name = "s3-2024-s3929994"
file_name = "s3929994.html"

# Create a session and an S3 client
s3 = boto3.client('s3')

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

if __name__ == "__main__":
    enable_static_website_hosting()
