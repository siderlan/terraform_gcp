module "qa" {
  source = "./modules/blog"

  app_name = "qa-blog"
  network_name = "qa"
}