data "archive_file" "lambda"{
type = "zip"
source_file = "return.py"
output_path = "${local.lambda_location}"
}

locals{
  lambda_location = "outputs/lambda.zip"
}
resource "aws_lambda_function" "test_lambda" {
  depends_on = [
    aws_security_group.allow_tls
  ]

  filename      = "${local.lambda_location}"
  function_name = "lambda_task"
  role          = aws_iam_role.lambda_role2.arn
  handler       = "return.lambda_handler"
  layers = [aws_lambda_layer_version.lambda_layer.arn]


 source_code_hash = filebase64sha256("${local.lambda_location}")

  runtime = "python3.9"
  timeout          = "30"
  memory_size      = 256
  publish          = true
 
 

}



resource "aws_lambda_layer_version" "lambda_layer" {
  filename   = "python.zip"
  layer_name = "Layer"
  compatible_runtimes = ["python3.9"]

}
