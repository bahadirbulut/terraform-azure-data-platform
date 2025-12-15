locals {
  name_prefix = "${var.project}-${var.env}"

  common_tags = merge(
    {
      project = var.project
      env     = var.env
      owner   = var.owner
      managed_by = "terraform"
    },
    var.extra_tags
  )
}
