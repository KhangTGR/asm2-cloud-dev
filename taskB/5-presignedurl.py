import boto3
import sys
import logging
from botocore.exceptions import NoCredentialsError, PartialCredentialsError

def create_presigned_url(bucket_name, object_name, expiration=60):
    """
    Generate a presigned URL to share an S3 object

    :param bucket_name: string
    :param object_name: string
    :param expiration: Time in seconds for the presigned URL to remain valid
    :return: Presigned URL as string. If error, returns None.
    """
    # Initialize a session using boto3
    s3_client = boto3.client('s3')

    try:
        response = s3_client.generate_presigned_url('get_object',
                                                    Params={'Bucket': bucket_name, 'Key': object_name},
                                                    ExpiresIn=expiration)
    except (NoCredentialsError, PartialCredentialsError) as e:
        logging.error("AWS credentials not configured properly: %s", e)
        return None
    except Exception as e:
        logging.error("Error generating presigned URL: %s", e)
        return None

    # The response contains the presigned URL
    return response

if __name__ == "__main__":
    # Define your bucket name and object name
    bucket_name = "s3-2024-s3929994"
    object_name = "s3929994.html"

    # Generate presigned URL
    url = create_presigned_url(bucket_name, object_name)

    if url:
        print("Presigned URL:")
        print(url)
        print("\nUse the following curl command to test the URL:")
        print(f"curl \"{url}\"")
    else:
        print("Failed to generate presigned URL.")
