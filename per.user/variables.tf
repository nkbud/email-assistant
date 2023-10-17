
data "aws_caller_identity" "current" {}

variable "username" {
  description = "i.e. nick.budzban"
}

variable "servername" {
  description = "i.e. oioio.email"
}


variable "tags" {
  description = "i.e. { Name: '' } "
}

variable "file_basename" {
  description = "i.e. 'emailhandler' from 'emailhandler.py'"
}
variable "method_name" {
  description = "i.e. 'handler' from handler(event, context) { }'"
}

variable "env" {
  description = "i.e. { FOO = 'BAR' }"
}