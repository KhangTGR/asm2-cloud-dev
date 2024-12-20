aws stepfunctions create-state-machine \
    --name s3929994-AUDExchange-StateMachine \
    --role-arn arn:aws:iam::$(aws sts get-caller-identity --query Account --output text):role/LabRole \
    --definition file://StateMachineDefinition.json \
    --region us-east-1
    
account_id=$(aws sts get-caller-identity --query Account --output text)

aws stepfunctions start-execution \
    --state-machine arn:aws:states:us-east-1:$account_id:stateMachine:s3929994-AUDExchange-StateMachine \
    --input '{"currency": "GBP", "amount": 50}'

aws stepfunctions start-execution \
    --state-machine arn:aws:states:us-east-1:$account_id:stateMachine:s3929994-AUDExchange-StateMachine \
    --input '{"currency": "XYZ", "amount": 100}'

aws stepfunctions start-execution \
    --state-machine arn:aws:states:us-east-1:$account_id:stateMachine:s3929994-AUDExchange-StateMachine \
    --input '{"currency": "USD", "amount": -1}'

aws stepfunctions start-execution \
    --state-machine arn:aws:states:us-east-1:$account_id:stateMachine:s3929994-AUDExchange-StateMachine \
    --input '{"currency": "NZD", "amount": 50}'

aws stepfunctions start-execution \
    --state-machine arn:aws:states:us-east-1:$account_id:stateMachine:s3929994-AUDExchange-StateMachine \
    --input '{"currency": "EUR", "amount": 5000}'
