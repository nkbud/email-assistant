
data "aws_caller_identity" "current" {}

variable "tags" {
  description = "i.e. { Name: '' } "
}

##
# The email address under surveillance
##

variable "user_name" {
  description = "i.e. nick.budzban"
}

variable "domain_name" {
  description = "i.e. oioio.email"
  default     = "oioio.email"
}

locals {
  email_address = "${var.user_name}@${var.domain_name}"
}

##
# Referencing the lambda's main method
##

variable "file_basename" {
  description = "i.e. 'index' from index.py"
  default     = "index"
}
variable "method_name" {
  description = "i.e. 'handler' from handler(event, context) { }"
  default     = "handler"
}

##
# Configuring the lambda
##

variable "lambda_env_vars" {
  description = "i.e. { FOO = 'BAR' }"
  default     = {}
}