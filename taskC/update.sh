## Update function
rm lambda_function.py
rm lambda_function.zip
cp lambda_function_v2.py lambda_function.py
zip lambda_function.zip lambda_function.py

aws lambda update-function-code \
    --function-name s3929994-function \
    --zip-file fileb://lambda_function.zip \
    --publish

aws lambda create-alias \
    --function-name s3929994-function \
    --name dev \
    --function-version "$(
        aws lambda list-versions-by-function \
            --function-name s3929994-function \
            --query 'Versions[?Version!=`$LATEST`].Version' \
            --output text
    )"
