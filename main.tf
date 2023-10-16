
##
# Config
##

locals {
  region      = "us-east-1"
  domain_name = "oioio.email"

  tags = {
    "terraform" = true
    "project"   = local.domain_name
  }
}

data "aws_caller_identity" "current" {}


##
# Modules
##

module "domain" {
  source      = "./per.domain"
  domain_name = local.domain_name
}

module "user" {
  source = "./per.user"
  for_each = toset([
    "nick.budzban"
  ])

  domain_name = local.domain_name
  user_name   = each.key

  tags = local.tags
}

##
# Providers
##

provider "template" {

}

provider "archive" {

}
