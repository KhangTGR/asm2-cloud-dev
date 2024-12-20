aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $(aws sts get-caller-identity --query Account --output text).dkr.ecr.us-east-1.amazonaws.com
docker tag app:s3929994 $(aws sts get-caller-identity --query Account --output text).dkr.ecr.us-east-1.amazonaws.com/ecr-s3929994-repo:s3929994
docker push $(aws sts get-caller-identity --query Account --output text).dkr.ecr.us-east-1.amazonaws.com/ecr-s3929994-repo:s3929994
