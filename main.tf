module "qa" {
  source = "./modules/blog"

  project_id   = var.project_id
  region       = var.region

  app_name     = "qa-blog"
  network_name = "qa"
}

module "staging" {
  source = "./modules/blog"

  project_id   = var.project_id
  region       = var.region

  app_name     = "staging-blog"
  network_name = "staging"
}

module "prod" {
  source = "./modules/blog"

  project_id   = var.project_id
  region       = var.region

  app_name     = "prod-blog"
  network_name = "prod"
}

module "cloudbuild-gitlab-connection" {
  source = "./modules/cloudbuild_gitlab_connection"

  project_id              = var.project_id
  region                  = var.region
  gitlab_api_token        = var.gitlab_api_token
  gitlab_read_api_token   = var.gitlab_read_api_token
}