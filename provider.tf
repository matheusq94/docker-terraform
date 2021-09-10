terraform {
    required_version = ">=0.13.1"
    backend "local" {
      path = "../../ivy-bot.tfstate"
    }
    required_providers {
        aws = ">=3.54.0"
        docker = {
            source = "kreuzwerker/docker"
            version = ">=2.15.0"
        }
    }
}
# provider.tf

# Specify the provider and access details
provider "aws" {
  region                  = var.aws_region
  access_key = "<Insert your access key ID here>"
  secret_key = "<Insert your secret access key here>"
}

data "aws_ecr_authorization_token" "token" {}
data "aws_region" "current" {}
data "aws_caller_identity" "this" {}

locals {
    ecr_adress = format("%v.dkr.ecr.%v.amazonaws.com", data.aws_caller_identity.this.account_id, data.aws_region.current.name)
    ecr_image = format("%v/%v:%v", local.ecr_adress, aws_ecr_repository.this.id, "latest")
}

provider "docker" {
    registry_auth {
      address = local.ecr_adress
      username = data.aws_ecr_authorization_token.token.user_name
      password = data.aws_ecr_authorization_token.token.password
    }
}