provider "aws" {
  region      = "us-east-1"
}

resource "aws_ecs_cluster" "qa" {
  name = "QA"
}

resource "aws_ecs_cluster" "Prod" {
  name = "Prod"
}