provider "aws" {
  region      = "us-east-1"
}

data "aws_ecs_task_definition" "centos"{
  task_definition = "${aws_ecs_task_definition.centos.family}"
}

resource "aws_ecs_cluster" "test" {
  name = "test"
}

resource "aws_ecs_task_definition" "centos" {
  family = "centos"

  container_definitions = <<DEFINITION
[
  {
    "cpu": 128,
    "environment": [{
      "name": "SECRET",
      "value": "KEY"
    }],

    "essential": true,
    "image": "centos:lates",
    "memory": 128,
    "memoryReservation": 64,
    "name": "centos"
  }
]
DEFINITION
}

resource "aws_ecs_service" "centos" {
  name          = "centos"
  cluster       = "${aws_ecs_cluster.test.id}"
  desired_count = 2
  launch_type   = "EC2" 
  task_definition = "${aws_ecs_task_definition.centos.family}:${max("${aws_ecs_task_definition.centos.revision}", "${data.aws_ecs_task_definition.centos.revision}")}"
}