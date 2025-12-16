# =============================================================================
# Databricks Scheduled Job Module
# =============================================================================
# Purpose: Daily ETL job running medallion architecture pipeline
#
# Pipeline Flow: Bronze (ingest) → Silver (cleanse) → Gold (aggregate)
# Schedule: Daily at 1:00 AM Europe/Brussels time
# Cluster: Ephemeral job cluster (cost-efficient)
# Notifications: Email alerts on failure
# =============================================================================

resource "databricks_job" "daily_orders_etl" {
  name            = "daily-orders-etl"
  timeout_seconds = 3600  # 1 hour maximum runtime

  # Cron schedule: daily at 1:00 AM
  schedule {
    quartz_cron_expression = "0 0 1 * * ?"  # Min Hour Day * * ?
    timezone_id            = "Europe/Brussels"
  }

  # Email notifications for operational monitoring
  email_notifications {
    on_failure                = var.notification_emails  # Alert on job failure
    no_alert_for_skipped_runs = true                     # Don't alert for skips
  }

  # Ephemeral job cluster - created on-demand, terminated after job
  # More cost-efficient than using persistent interactive clusters
  job_cluster {
    job_cluster_key = "etl_cluster"

    new_cluster {
      spark_version = "13.3.x-scala2.12"  # LTS version for stability
      node_type_id  = var.node_type_id    # VM size
      num_workers   = var.num_workers      # Cluster size
    }
  }

  # ==========================================================================
  # Task 1: Bronze - Raw Data Ingestion
  # ==========================================================================
  task {
    task_key        = "bronze"
    job_cluster_key = "etl_cluster"

    notebook_task {
      notebook_path = "${var.repo_base_path}/databricks/notebooks/01_bronze_ingest"
      # Automatically pass storage account name to notebook
      base_parameters = var.storage_account_name != "" ? {
        storage_account_name = var.storage_account_name
      } : {}
    }
  }

  # ==========================================================================
  # Task 2: Silver - Data Cleansing
  # ==========================================================================
  # Depends on Bronze task completion
  task {
    task_key        = "silver"
    job_cluster_key = "etl_cluster"

    depends_on {
      task_key = "bronze"  # Wait for Bronze to complete
    }

    notebook_task {
      notebook_path = "${var.repo_base_path}/databricks/notebooks/02_silver_cleanse"
      base_parameters = var.storage_account_name != "" ? {
        storage_account_name = var.storage_account_name
      } : {}
    }
  }

  # ==========================================================================
  # Task 3: Gold - Business Aggregations
  # ==========================================================================
  # Depends on Silver task completion
  task {
    task_key        = "gold"
    job_cluster_key = "etl_cluster"

    depends_on {
      task_key = "silver"  # Wait for Silver to complete
    }

    notebook_task {
      notebook_path = "${var.repo_base_path}/databricks/notebooks/03_gold_aggregate"
      base_parameters = var.storage_account_name != "" ? {
        storage_account_name = var.storage_account_name
      } : {}
    }
  }
}
