# module "qa" {
#   source = "./modules/blog"

#   project_id   = var.project_id
#   region       = var.region

#   app_name     = "qa-blog"
#   network_name = "qa"
# }

# module "staging" {
#   source = "./modules/blog"

#   project_id   = var.project_id
#   region       = var.region

#   app_name     = "staging-blog"
#   network_name = "staging"
# }

# module "prod" {
#   source = "./modules/blog"

#   project_id   = var.project_id
#   region       = var.region

#   app_name     = "prod-blog"
#   network_name = "prod"
# }

locals {
  repositories = [
    {
      name = "playground-svc"
      uri  = "https://gitlab.com/ferreri/angeplus/angeplus-playground-svc.git"
    },
    {
      name = "term-svc"
      uri  = "https://gitlab.com/ferreri/angeplus/angeplus-term-svc.git"
    }
  ]
}

module "cloudbuild-gitlab-connection" {
  source = "./modules/cloudbuild_gitlab_connection"

  project_id              = var.project_id
  region                  = var.region
  gitlab_api_token        = var.gitlab_api_token
  gitlab_read_api_token   = var.gitlab_read_api_token
}

module "cloudbuild_repository" {
  source = "./modules/cloudbuild_repository"

  location  = var.region
  parent_connection = module.cloudbuild-gitlab-connection.id
  for_each  = { for k, repo in flatten(local.repositories) : k => repo }
  repo_name = each.value.name
  repo_uri  = each.value.uri
}