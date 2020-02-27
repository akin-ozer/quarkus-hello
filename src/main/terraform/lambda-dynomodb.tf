resource "aws_dynamodb_table" "challenge-vpclist" {
  name = "challenge-vpclist"
  hash_key = "id"
  read_capacity = 1
  write_capacity = 1

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name = "DynamoDB Lambda Storage"
  }
}