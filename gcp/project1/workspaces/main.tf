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

resource "google_compute_instance" "createnewvm" {
  name         = "test"
  machine_type = lookup(var.vm-types,terraform.workspace)
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "terraform-network"

    access_config {
    }
  }
}

variable "vm-types" {
  type = map
  default = {
    dev = "e2-small"
    qa = "e2-medium"
  }
}
