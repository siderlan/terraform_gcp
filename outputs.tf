# output "qa_ip" {
#   value = module.qa.public_ip
# }

# output "staging_ip" {
#   value = module.staging.public_ip
# }

# output "prod_ip" {
#   value = module.prod.public_ip
# }

output "cloudbuild_gitlab_connection_id" {
  value = module.cloudbuild-gitlab-connection.id
}