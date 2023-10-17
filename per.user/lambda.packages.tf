
##
# Lambda layer: packages.zip
##

resource "aws_lambda_layer_version" "packages" {
  filename            = "${path.module}/lambda/packages.zip"
  layer_name          = "packages"
  compatible_runtimes = ["python3.9"]
}
