variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "connection_name" {
  type = string
  default = "gitlab-connection"
}

variable "gitlab_api_token" {
  type = string
  sensitive = true
}

variable "gitlab_read_api_token" {
  type = string
  sensitive = true
}

variable "gitlab_webhook_token" {
  type = string
  default = ""
  sensitive = true
}