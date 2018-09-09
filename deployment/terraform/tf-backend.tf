terraform {
  backend "s3" {
    bucket = "tf-backend"
    key    = "statefile"
    region = "us-west-2"
  }
}