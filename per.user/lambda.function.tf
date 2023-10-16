
##
# From
##

resource "aws_lambda_function" "handler" {
  function_name = local.email_address
  runtime       = "python3.9"

  # lambda.zip
  filename         = data.archive_file.lambda.output_path
  source_code_hash = filebase64sha256(data.archive_file.lambda.output_path)
  handler          = "${var.file_basename}.${var.method_name}"

  # packages.zip
  layers = [
    aws_lambda_layer_version.packages.arn
  ]

  environment {
    variables = var.lambda_env_vars
  }
  tags = var.tags

  tracing_config {
    mode = "Active"
  }
  role = aws_iam_role.lambda.arn
}
