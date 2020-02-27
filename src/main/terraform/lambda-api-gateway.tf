resource "aws_api_gateway_rest_api" "ChallengeAPI" {
  name = "ChallengeAPI"
  description = "This is my API for demonstration purposes"
}

resource "aws_api_gateway_resource" "ChallengeAPIResource" {
  rest_api_id = aws_api_gateway_rest_api.ChallengeAPI.id
  parent_id = aws_api_gateway_rest_api.ChallengeAPI.root_resource_id
  path_part = "mydemoresource"
}

resource "aws_api_gateway_method" "ChallengeAPIMethod" {
  rest_api_id = aws_api_gateway_rest_api.ChallengeAPI.id
  resource_id = aws_api_gateway_resource.ChallengeAPIResource.id
  http_method = "GET"
  authorization = "NONE"
}
resource "aws_api_gateway_rest_api" "ChallengeAPIGateway" {
  name = "ChallengeAPIGateway"
}

resource "aws_api_gateway_resource" "resource" {
  path_part = "resource"
  parent_id = aws_api_gateway_rest_api.ChallengeAPIGateway.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.ChallengeAPIGateway.id
}

resource "aws_api_gateway_method" "method" {
  rest_api_id = aws_api_gateway_rest_api.ChallengeAPIGateway.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id = aws_api_gateway_rest_api.ChallengeAPIGateway.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.method.http_method
  integration_http_method = "POST"
  type = "AWS_PROXY"
  uri = aws_lambda_function.lambda_zip_inline.invoke_arn
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_zip_inline.function_name
  principal = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.ChallengeAPIGateway.id}/*/${aws_api_gateway_method.method.http_method}${aws_api_gateway_resource.resource.path}"
}