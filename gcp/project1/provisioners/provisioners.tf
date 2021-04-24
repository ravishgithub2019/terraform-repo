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

/*
resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}*/

resource "google_compute_firewall" "firewall-12345" {
  name    = "firewall-12345-externalssh"
  network = "terraform-network"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["externalssh"]
}


resource "google_compute_project_metadata" "my_ssh_key" {
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}



resource "google_compute_instance" "provisoner-vm" {
  name         = "provisioner-3"
  machine_type = "e2-small"
  zone         = "us-central1-a"
  tags         = ["externalssh"]


  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

    network_interface {
      network = "terraform-network"
      access_config {
      }
    }

  /*
    provisioner "local-exec" {
      command = "echo machine-ip :" self.external_ip
    }
*/

    provisioner "remote-exec" {
      inline = [
        "date",
        "pwd",
        "sudo apt install nginx -y"
      ]

      connection {
          type     = "ssh"
          user     = "ubuntu"
          private_key = file("~/.ssh/id_rsa")
          host     = self.network_interface[0].access_config[0].nat_ip

      }
    }

    depends_on = [google_compute_firewall.firewall-12345,google_compute_project_metadata.my_ssh_key]
}
