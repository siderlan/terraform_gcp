variable "project_id" {
  type = string
  default = "terraform-416914"
}

variable "region" {
  type = string
  default  = "us-west1"
}

variable "network_name" {
  type = string
  default = "app"
}

variable "app_name" {
  type = string
  default = "blog"
}

variable "gitlab_api_token" {
  type = string
}

variable "gitlab_read_api_token" {
  type = string
}