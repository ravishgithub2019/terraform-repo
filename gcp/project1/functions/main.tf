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

output "key" {
  value = file("/home/ubuntu/Desktop/terraform/gcp/project710-73eb78881b78.json")
}

locals {
  DT = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
}

output "current_time" {
  value = local.DT
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

variable "region" {
  default = "east"
}

variable "machines-zones" {
  type = map
  default = {
    east = "us-east1-b"
    west = "us-west1-a"
    central = "us-central1-a"
  }
}

resource "google_compute_instance" "my-vm" {
  name         = "functions-test"
  machine_type = "e2-small"
  zone         = lookup(var.machines-zones,var.region,"us-central1-a")

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

    network_interface {
      network = google_compute_network.vpc_network.name
      access_config {
      }
    }
}
