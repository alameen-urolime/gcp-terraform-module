# resource "google_cloudbuild_trigger" "cloudbuild-app-trigger" {
#   for_each = var.branches

#   name     = "${var.trigger}-${each.key}"
#   filename = var.filename
#   github {
#     owner = var.git-username
#     name  = var.git-repo
#     push {
#       branch = each.value
#     } 
#   }
# }


resource "google_cloudbuild_trigger" "cloudbuild-app-trigger" {
  for_each = var.branches

  name     = "${var.trigger}-${each.key}"
  filename = each.value["filename"] 
  github {
    owner = var.git-username
    name  = var.git-repo
    push {
      branch = each.value["branch"]
    }
  }
}