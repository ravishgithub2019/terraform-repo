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

locals {
  instanceID = "test-locals"
}


resource "google_compute_instance" "my-vm" {
  name         = local.instanceID
  machine_type = "e2-small"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "buntu-os-cloud/ubuntu-2004-lts"
    }
  }

    network_interface {
      network = google_compute_network.vpc_network.name
      access_config {
      }
    }
}
