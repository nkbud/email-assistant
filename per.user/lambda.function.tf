

resource "aws_lambda_function" "lambda" {
  function_name    = var.name
  filename         = data.archive_file.lambda.output_path
  source_code_hash = filebase64sha256(data.archive_file.lambda.output_path)
  role             = aws_iam_role.lambda.arn
  handler          = "${var.file_basename}.${var.method_name}"
  runtime          = "python3.9"
  environment {
    variables = var.env
  }
  tracing_config {
    mode = "Active"
  }
  layers = [
    aws_lambda_layer_version.packages.arn
  ]
  tags = var.tags
}
