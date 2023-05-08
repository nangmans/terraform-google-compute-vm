terraform {
  backend "gcs" {
    prefix = "terraform/prj-cc-production-devops-0006/vm-prod-test"
    bucket = "bkt-tfstate-mkt-prod"
  }
}


