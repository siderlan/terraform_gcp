resource "google_cloudbuildv2_repository" "cloudbuild_repository" {
  name = var.repo_name
  location = var.location
  parent_connection = var.parent_connection
  remote_uri = var.repo_uri
}

resource "google_cloudbuild_trigger" "cloudbuild_qas_trigger" {
  name = "${var.repo_name}-qas"
  location = var.location
  repository_event_config {
    repository = google_cloudbuildv2_repository.cloudbuild_repository.id
    push {
      branch = "main"
    }
  }
  filename = "cloudbuild.yaml"
}