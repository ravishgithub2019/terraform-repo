terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}
provider "google" {

  credentials = file("/home/ubuntu/Desktop/terraform/gcp/project710-73eb78881b78.json")
  project = "project710"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_service_account" "service_account" {
  account_id   = "service-account-${count.index}"
  display_name = "Service Account"
  count = 3
}

output "svcid" {
  value = google_service_account.service_account[*].unique_id
}

output "svcname" {
  value = google_service_account.service_account[*].name
}

/*
output "svcid" {
  value = zipmap(["svc1","svc2","svc3"],[1,2,3])
}
*/


output "svcfulldetails" {
  value = zipmap(google_service_account.service_account[*].unique_id,google_service_account.service_account[*].name)
}
