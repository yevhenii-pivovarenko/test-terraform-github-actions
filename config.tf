variable "project" { type = string }
variable "region" { type = string }
variable "zone" { type = string }

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.12.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "random_id" "rand" {
  byte_length = 8
}

resource "google_storage_bucket" "bucket" {
  name                        = "${random_id.rand.hex}-code-source"
  location                    = var.region
  uniform_bucket_level_access = true
}

data "archive_file" "code" {
  type        = "zip"
  output_path = "/tmp/gcp-function.zip"
  source_file = "main.py"
}

resource "google_storage_bucket_object" "code" {
  name   = "gcp-function.zip"
  bucket = google_storage_bucket.bucket.name
  source = data.archive_file.code.output_path
}

resource "google_cloudfunctions2_function" "punk" {
  name        = "simple-test-func"
  description = "hello-world like function that accepts simple calls and returns happy message"
  location    = var.region

  build_config {
    runtime     = "python312"
    entry_point = "hello"
    source {
      storage_source {
        bucket = google_storage_bucket.bucket.name
        object = google_storage_bucket_object.code.name
      }
    }
  }

  service_config {
    timeout_seconds                  = 15
    available_memory                 = "128Mi"
    max_instance_count               = 1
    max_instance_request_concurrency = 1
  }
}