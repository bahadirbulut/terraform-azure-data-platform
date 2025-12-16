# Databricks notebook source
# =============================================================================
# Silver Layer - Data Cleansing and Quality
# =============================================================================
# Author: Bahadir Bulut <bahadir.bulut@nexence.be>
# Purpose: Cleanse and validate data from Bronze layer for analytics consumption
#
# Layer: Silver (Cleansed Data)
# Input: Delta table from abfss://bronze@{storage}/orders/
# Output: Delta table in abfss://silver@{storage}/orders/
# Mode: Overwrite (full refresh with latest cleansed data)
#
# Transformations:
# - Remove duplicate records based on order_id
# - Cast quantity to integer type
# - Cast unit_price to double precision
#
# This is the second step in the medallion architecture, where we ensure
# data quality and consistency for downstream analytics.
# =============================================================================

from pyspark.sql.functions import col
from pyspark.sql import SparkSession

# Initialize Spark session
spark = SparkSession.builder.getOrCreate()

# =============================================================================
# Configuration
# =============================================================================
# Get storage account name from widget parameter
dbutils.widgets.text("storage_account_name", "", "Storage Account Name")
storage_account = dbutils.widgets.get("storage_account_name")

# Construct paths for Bronze (input) and Silver (output) layers
bronze_path = f"abfss://bronze@{storage_account}.dfs.core.windows.net/orders/"
silver_path = f"abfss://silver@{storage_account}.dfs.core.windows.net/orders/"

# =============================================================================
# Data Cleansing
# =============================================================================
# Read data from Bronze layer
# Delta format allows us to read the latest version automatically
df = spark.read.format("delta").load(bronze_path)

# Apply cleansing transformations:
# 1. Remove duplicate records - keeping only unique order_id values
# 2. Cast quantity from string to integer for numerical operations
# 3. Cast unit_price from string to double for precise calculations
df_clean = (
    df.dropDuplicates(["order_id"])  # Deduplication based on business key
      .withColumn("quantity", col("quantity").cast("int"))  # Type casting
      .withColumn("unit_price", col("unit_price").cast("double"))  # Type casting
)

# =============================================================================
# Write to Silver Layer
# =============================================================================
# Overwrite mode: Replace entire table with cleansed data
# This ensures Silver always reflects the latest clean state
df_clean.write.mode("overwrite").format("delta").save(silver_path)

print(f"Successfully cleansed {df_clean.count()} records to Silver layer")
print(f"Removed {df.count() - df_clean.count()} duplicate records")
