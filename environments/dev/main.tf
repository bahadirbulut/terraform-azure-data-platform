module "platform" {
  source = "../../"

  project  = "nexence"
  env      = "dev"
  owner    = "bahadir"
  location = "westeurope"

  adls_container_names = ["bronze", "silver", "gold"]
  databricks_sku       = "premium"

  extra_tags = {
    cost_center = "portfolio"
  }
}
