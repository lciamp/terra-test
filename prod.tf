
data "aws_ecs_task_definition" "centos-prod"{
  task_definition = "${aws_ecs_task_definition.centos-prod.family}"
}


resource "aws_ecs_task_definition" "centos-prod" {
  family = "centos-prod"

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
    "name": "centos",
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ]
  }
]
DEFINITION
}

resource "aws_ecs_service" "centos-prod" {
  name          = "centos-prod"
  cluster       = "${aws_ecs_cluster.Prod.id}"
  desired_count = 2
  launch_type   = "EC2" 
  task_definition = "${aws_ecs_task_definition.centos-prod.family}:${max("${aws_ecs_task_definition.centos-prod.revision}", "${data.aws_ecs_task_definition.centos-prod.revision}")}"
}