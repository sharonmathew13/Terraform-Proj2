terraform {
  backend "s3" {
    bucket = "jenkins-s3-1303"
    key    = "remote.tfstate"
    region = "us-east-1"
  }
}