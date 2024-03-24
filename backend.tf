terraform {
  backend "s3" {
    bucket         = "harsh-987123"
    key            = "terraform.tfstate"
    region         = "us-east-1"
     encrypt        	   = true
    dynamodb_table = "lock_id_terraform"
  }
}
