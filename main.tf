module "qa" {
  source = "./modules/blog"

  app_name = "qa_blog"
  network_name = "qa"
}