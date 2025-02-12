import json

def lambda_handler(event, context):
    start_time = event['start_time']
    end_time = event['end_time']
    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps(f"Hello from Lambda! Time interval: {start_time} - {end_time}")
    }
