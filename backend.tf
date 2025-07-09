terraform {
  backend "s3" {
    bucket         = "file.tfstate"
    key            = "backend.tf"
    region         = "us-east-1"
    dynamodb_table = "tf-backend"
  }
}