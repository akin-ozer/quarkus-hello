data "archive_file" "lambda_zip_inline" {
  type        = "zip"
  output_path = "/tmp/lambda_zip_inline.zip"
  source {
    content  = <<EOF
import json
import boto3

def calculate():
    ec2 = boto3.resource("ec2")
    dynamodb = boto3.client('dynamodb')
    x = 0
    y = 0
    for vpc in ec2.vpcs.all():
        for subnet in vpc.subnets.all():
            print(vpc, "all:", subnet)
            dynamodb.put_item(TableName='challenge-vpclist',
                Item={
                    'id': {"S": str(x) + str(y) },
                    'vpc': {"S": vpc.vpc_id },
                    'subnet': {"S": subnet.subnet_id }
                }
            )
            y += 1
    x += 1

def lambda_handler(event, context):
    # TODO implement
    calculate()
    return {
        'statusCode': 200,
        'body': json.dumps('Data written')
    }
EOF
    filename = "main.py"
  }
}

resource "aws_lambda_function" "lambda_zip_inline" {
  filename         = data.archive_file.lambda_zip_inline.output_path
  source_code_hash = data.archive_file.lambda_zip_inline.output_base64sha256
  function_name = "challenge-lambda"
  handler = "main.lambda_handler"
  role = "arn:aws:iam::650049577739:role/lamda-admin"
  runtime = "python3.7"
  memory_size = "1024"
  timeout = 8
}