variable "region" {
    description = "The AWS region to create resources in."
    default = "us-east-1"
}

//variable "aws_access_key_id" {}
//variable "aws_secret_access_key" {}
variable "aws_zones" {
  type        = "list"
  description = "List of availability zone to use"
  default     = ["us-east-1c", "us-east-1d", "us-east-1e"]
}

variable "clusters" {
  type = "list"
  description = "List of ECS Clusters"
  default = ["Non-Production-Services", "Production-Services-DMZ", "Non-Production-Services-DMZ", "Production-Services"]
}