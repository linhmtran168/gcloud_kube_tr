terraform {
  backend "gcs" {}
}

provider "google" {
  credentials = file("key.json")
  project = var.project
  region = var.region
}