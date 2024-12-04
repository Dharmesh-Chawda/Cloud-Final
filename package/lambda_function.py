import json
import boto3

dynamodb = boto3.resource('dynamodb')
sqs = boto3.client('sqs')

def lambda_handler(event, context):
    table_name = event.get("dynamodb_table")
    queue_url = event.get("sqs_queue_url")

    # Write to DynamoDB
    table = dynamodb.Table(table_name)
    table.put_item(Item={"MessageID": "123", "Content": "Hello from Lambda"})

    # Send a message to SQS
    sqs.send_message(QueueUrl=queue_url, MessageBody="Hello from Lambda")

    return {
        "statusCode": 200,
        "body": json.dumps("Message processed successfully!")
    }
