variable "trigger" {
  type        = string
  description = "Google Cloud Build trigger Name"
}

# variable "filename" {
#   type        = string
#   description = "Google Cloud Build-File Name"
# }

variable "branches" {
  type = map(object({
    filename = string
    branch   = string
  }))
  default = {
    dev = {
      filename = "cloudbuild-dev.yaml"
      branch   = "dev"
    }
    prod = {
      filename = "cloudbuild-prod.yaml"
      branch   = "prod"
    }
  }
}


variable "git-username" {
  type        = string
  description = "GitHub UserName"
}

variable "git-repo" {
  type        = string
  description = "GitHub repository name"
}

# variable "branches" {
#   description = "Map of branches to trigger on"
#   type        = map(string)
# }