

#
## Lambda handler: index.py [, others.py] --> lambda.zip
#

data "template_file" "index" {
  template = file("${path.module}/${var.user_name}/${var.file_basename}.py")
}

data "archive_file" "lambda" {
  source {
    content  = data.template_file.index.rendered
    filename = "${var.file_basename}.py"
  }
  type        = "zip"
  output_path = "${path.module}/${var.user_name}/lambda.zip"
}

##
# Lambda layer: pip install packages/* --> packages.zip
##

resource "aws_lambda_layer_version" "packages" {
  filename            = "${path.module}/${var.user_name}/packages.zip"
  layer_name          = "packages"
  compatible_runtimes = ["python3.9"]
}

