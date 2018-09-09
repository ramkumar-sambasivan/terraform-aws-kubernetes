provider "aws" {
  region     = "${var.aws_region}"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
}

variable "cluster-name" {
  default = "terraform-dev"
  type    = "string"
}

variable "aws_region" {
  default = "us-west-2"
  type    = "string"
}

variable "aws_access_key" {
  type    = "string"
}

variable "aws_secret_key" {
  type    = "string"
}