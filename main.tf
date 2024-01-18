# main.tf

provider "aws" {
  region = var.aws_region
}

module "example_security_group" {
  source = "./security_group.tf"
}
