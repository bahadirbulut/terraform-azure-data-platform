# Databricks notebook source
# =============================================================================
# Gold Layer - Business Aggregations
# =============================================================================
# Author: Bahadir Bulut <bahadir.bulut@nexence.be>
# Purpose: Create business-level aggregations for analytics and reporting
#
# Layer: Gold (Aggregated Data)
# Input: Delta table from abfss://silver@{storage}/orders/
# Output: Delta table in abfss://gold@{storage}/daily_revenue/
# Mode: Overwrite (refresh aggregated metrics)
#
# Business Logic:
# - Calculate total revenue per order (quantity * unit_price)
# - Aggregate revenue by order_date to get daily totals
# - Provide ready-to-use metrics for dashboards and reports
#
# This is the final step in the medallion architecture, producing
# business-ready, aggregated data optimized for analytics consumption.
# =============================================================================

from pyspark.sql.functions import col, sum
from pyspark.sql import SparkSession

# Initialize Spark session
spark = SparkSession.builder.getOrCreate()

# =============================================================================
# Configuration
# =============================================================================
# Get storage account name from widget parameter
dbutils.widgets.text("storage_account_name", "", "Storage Account Name")
storage_account = dbutils.widgets.get("storage_account_name")

# Construct paths for Silver (input) and Gold (output) layers
silver_path = f"abfss://silver@{storage_account}.dfs.core.windows.net/orders/"
gold_path = f"abfss://gold@{storage_account}.dfs.core.windows.net/daily_revenue/"

# =============================================================================
# Business Aggregations
# =============================================================================
# Read cleansed data from Silver layer
df = spark.read.format("delta").load(silver_path)

# Calculate business metrics:
# 1. Add calculated column: revenue = quantity × unit_price
# 2. Group by order_date to aggregate daily totals
# 3. Sum revenue for each date to get daily_revenue
df_gold = (
    df.withColumn("revenue", col("quantity") * col("unit_price"))  # Calculate order revenue
      .groupBy("order_date")  # Aggregate by date
      .agg(sum("revenue").alias("daily_revenue"))  # Sum revenue per day
)

# =============================================================================
# Write to Gold Layer
# =============================================================================
# Overwrite mode: Replace with latest aggregated metrics
# Gold tables are optimized for fast analytical queries
df_gold.write.mode("overwrite").format("delta").save(gold_path)

print(f"Successfully aggregated revenue for {df_gold.count()} days to Gold layer")
