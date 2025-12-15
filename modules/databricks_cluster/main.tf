data "databricks_spark_version" "lts" {
  long_term_support = true
}

resource "databricks_cluster" "this" {
  cluster_name = var.cluster_name

  spark_version = (
    var.spark_version != ""
    ? var.spark_version
    : data.databricks_spark_version.lts.id
  )

  node_type_id            = var.node_type_id
  num_workers             = var.num_workers
  autotermination_minutes = var.autotermination_minutes

  # Keep it simple for portfolio
  data_security_mode = var.data_security_mode
}
