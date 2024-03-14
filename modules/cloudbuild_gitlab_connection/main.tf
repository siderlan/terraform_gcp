data "google_project" "gcp_project" {
  project_id = var.project_id
}

locals {
  api_token_name        = "gitlab_api_token"
  api_read_token_name   = "gitlab_read_api_token"
  webhook_token_name    = "gitlab_webhook_token"
  automatic_replication = true
  cloudbuild_sa         = "serviceAccount:service-${data.google_project.gcp_project.number}@gcp-sa-cloudbuild.iam.gserviceaccount.com"
}

module "cloudbuild_secret_manager" {
  source  = "GoogleCloudPlatform/secret-manager/google"
  version = "~> 0.2"

  project_id = var.project_id
  secrets = [
    {
      name                     = local.api_token_name
      automatic_replication    = local.automatic_replication
      secret_data              = var.gitlab_api_token
    },
    {
      name                     = local.api_read_token_name
      automatic_replication    = local.automatic_replication
      secret_data              = var.gitlab_read_api_token
    },
    {
      name                     = local.webhook_token_name
      automatic_replication    = local.automatic_replication
      secret_data              = var.gitlab_webhook_token
    },
  ]
}

resource "google_secret_manager_secret_iam_binding" "binding" {
  project   = var.project_id
  for_each  = { for secret in module.cloudbuild_secret_manager.secret_versions : secret.name => secret }
  secret_id = each.value.name
  role      = "roles/secretmanager.secretAccessor"
  members   = [local.cloudbuild_sa]
}

resource "google_cloudbuildv2_connection" "gitlab_connection" {
  location = var.region
  name = var.connection_name

  gitlab_config {
    authorizer_credential {
        user_token_secret_version = module.cloudbuild_secret_manager.secret_versions[0]
    }
    read_authorizer_credential {
        user_token_secret_version = module.cloudbuild_secret_manager.secret_versions[1]
    }
    webhook_secret_secret_version = module.cloudbuild_secret_manager.secret_versions[2]
  }
}