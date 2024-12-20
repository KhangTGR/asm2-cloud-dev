import json

EXCHANGE_RATES = {
    "usd": 0.69,
    "gbp": 0.52,
    "nzd": 1.05,
    "eur": 0.62
}

def lambda_handler(event, context):
    try:
        currency = event.get("currency", "").lower()
        amount = event.get("amount")
        
        # Validate currency
        if currency not in EXCHANGE_RATES:
            return {
                "statusCode": 400,
                "body": "Invalid Currency"
            }
        
        # Validate amount
        if not isinstance(amount, (int, float)) or amount <= 0:
            return {
                "statusCode": 400,
                "body": "Invalid Amount"
            }
        
        # Calculate AUD equivalent
        rate = EXCHANGE_RATES[currency]
        aud_value = amount * rate
        return {
            "statusCode": 200,
            "AUD": aud_value
        }
    except Exception as e:
        return {
            "statusCode": 500,
            "body": f"Error: {str(e)}"
        }
