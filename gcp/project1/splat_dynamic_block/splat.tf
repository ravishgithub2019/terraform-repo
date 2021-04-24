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

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

variable "svc-accounts" {
  type = map
  default = {
    dev-svc = "compute-dev"
    qa-svc = "compute-qa"
    prod-svc = "compute-prod"
  }
}

variable "account-numbers" {
  type = list
  default = [10,20,30]
}

output "service-accounts" {
  value = var.account-numbers[*]
}
