resource "aws_ecr_repository" "this" {
  name = "devops-challenge-ecr-repo" # Naming my repository
}

resource "docker_registry_image" "app" {
   name = local.ecr_image

   build {
       context = "${path.cwd}/"
   }

   depends_on = [
     aws_ecr_repository.this
   ]
}