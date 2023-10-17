

#
## Lambda code: lambda.zip
#

data "template_file" "lambda" {
  template = file("${path.module}/lambda/lambda.zip")
}
data "archive_file" "lambda" {
  type        = "zip"
  output_path = "${path.module}/lambda/lambda.zip"
  source {
    content  = data.template_file.lambda.rendered
    filename = "${var.file_basename}.py"
  }
}