terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
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
  account_id   = var.vm-id[count.index]
  display_name = var.sa-name[count.index]
  count        = 3
}
