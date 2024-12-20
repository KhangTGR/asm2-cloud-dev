import boto3
from botocore.exceptions import NoCredentialsError, ClientError

# Input variables
bucket_name = "s3-2024-s3929994"
file_name = "s3929994.html"

# Create a session and an S3 client
s3 = boto3.client('s3')

def upload_file():
    try:
        # Upload the file to the S3 bucket with the correct Content-Type
        s3.upload_file(file_name, bucket_name, file_name, ExtraArgs={'ContentType': 'text/html'})
        print(f"File '{file_name}' uploaded to bucket '{bucket_name}' with content-type 'text/html'.")
    except FileNotFoundError:
        print(f"Error: The file '{file_name}' was not found.")
    except NoCredentialsError:
        print("Error: AWS credentials not found.")
    except ClientError as e:
        print(f"Error uploading file: {e}")

if __name__ == "__main__":
    upload_file()
