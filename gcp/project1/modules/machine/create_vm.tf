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
  name = var.nwkname
}

resource "google_compute_instance" "module-vm" {
  name         = var.vmname
  machine_type = "e2-small"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    network = var.nwkname


  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"
}
