terraform {
    required_version = ">=0.13.1"
    required_providers {
        aws = ">=3.54.0"
        docker = {
            source = "kreuzwerker/docker"
            version = ">=2.15.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
}

resource "aws_ecr_repository" "devops_challenge_ecr_repo" {
  name = "devops-challenge-ecr-repo" # Naming my repository
}

data "aws_ecr_authorization_token" "token" {}
data "aws_region" "current" {}
data "aws_caller_identity" "this" {}

locals {
    ecr_adress = format("%v.dkr.ecr.%v.amazonaws.com", data.aws_caller_identity.this.account_id, data.aws_region.current.name)
    ecr_image = format("%v/%v:%v", local.ecr_adress, aws_ecr_repository.devops_challenge_ecr_repo.id, "1.0")
}

provider "docker" {
    #host = "unix:///var/run/docker.sock"
    registry_auth {
      address = local.ecr_adress
      username = data.aws_ecr_authorization_token.token.user_name
      password = data.aws_ecr_authorization_token.token.password
    }
}


 resource "docker_registry_image" "app" {
   name = local.ecr_image

   build {
       context = "${path.cwd}/"
   }
}