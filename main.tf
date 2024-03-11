module "qa" {
  source = "./modules/blog"

  project_id   = var.project_id
  region       = var.region

  app_name     = "qa-blog"
  network_name = "qa"
}