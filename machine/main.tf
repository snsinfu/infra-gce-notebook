terraform {
  backend "gcs" {
    prefix = "terraform"
  }
}

provider "google" {
  project = "${var.google_project}"
}

#
# Network
#

resource "google_compute_network" "main" {
  name = "main"
}

resource "google_compute_firewall" "ssh" {
  name      = "ssh"
  network   = "${google_compute_network.main.name}"
  direction = "INGRESS"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

#
# Instance
#

resource "google_compute_instance" "main" {
  name         = "main"
  machine_type = "${var.machine_type}"
  zone         = "${var.google_zone}"

  boot_disk {
    initialize_params {
      type  = "${var.disk_type}"
      size  = "${var.disk_size}"
      image = "${var.machine_image}"
    }
  }

  network_interface {
    network = "${google_compute_network.main.name}"
    access_config {}
  }

  guest_accelerator {
    type  = "${var.accelerator_type}"
    count = "${var.accelerator_count}"
  }

  metadata = {
    user-data = "${data.template_file.cloudinit.rendered}"
  }

  service_account {
    scopes = ["storage-full"]
  }

  scheduling {
    preemptible         = true
    automatic_restart   = false
    on_host_maintenance = "TERMINATE"
  }
}

data "template_file" "cloudinit" {
  template = "${file("cloudinit.yml.in")}"

  vars {
    ssh_user       = "${var.ssh_user}"
    ssh_pubkeys    = "${jsonencode(var.ssh_pubkeys)}"
    storage_bucket = "${var.storage_bucket}"
  }
}
