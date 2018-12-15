provider "google" {
  project = "${var.google_project}"
}

resource "google_storage_bucket" "main" {
  name          = "${var.storage_bucket}"
  location      = "${var.storage_location}"
  storage_class = "${var.storage_class}"
  force_destroy = true
}
