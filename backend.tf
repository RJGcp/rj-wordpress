terraform {
  backend "gcs" {
    bucket = "rj-state"
    prefix = "rj-wp"
  }
}