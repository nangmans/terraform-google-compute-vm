terraform {
  backend "gcs" {
    prefix = "terraform/prj-cc-production-devops-0006/vm-mkt-prod-test"
    bucket = "bkt-tfstate-wmp-mkt-prod"
  }
}


