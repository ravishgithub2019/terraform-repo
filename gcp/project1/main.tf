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

resource "google_compute_address" "static" {
  name = "ipv4-address"
}

# machine1

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance-1"
  machine_type = var.machine_types["dev"]
  tags         = ["prod","web"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }
}
output "instance_name" {
    value = google_compute_instance.vm_instance.name
  }
