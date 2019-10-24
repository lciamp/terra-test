

data "aws_ecs_task_definition" "centos-qa"{
  task_definition = "${aws_ecs_task_definition.centos-qa.family}"
}


resource "aws_ecs_task_definition" "centos-qa" {
  family = "centos-qa"

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

resource "aws_ecs_service" "centos-qa" {
  name          = "centos-qa"
  cluster       = "${aws_ecs_cluster.qa.id}"
  desired_count = 2
  launch_type   = "EC2" 
  task_definition = "${aws_ecs_task_definition.centos-qa.family}:${max("${aws_ecs_task_definition.centos-qa.revision}", "${data.aws_ecs_task_definition.centos-qa.revision}")}"
}