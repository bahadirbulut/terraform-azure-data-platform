# Databricks notebook source
# =============================================================================
# Bronze Layer - Raw Data Ingestion
# =============================================================================
# Author: Bahadir Bulut <bahadir.bulut@nexence.be>
# Purpose: Ingest raw CSV data from sample source into Bronze Delta Lake table
#
# Layer: Bronze (Raw Data)
# Input: CSV files from dbfs:/FileStore/sample_data/orders/
# Output: Delta table in abfss://bronze@{storage}/orders/
# Mode: Append (preserves all raw data for audit trail)
#
# This notebook is the first step in the medallion architecture pipeline.
# It reads raw data as-is without transformation and stores it in Delta format.
# =============================================================================

from pyspark.sql import SparkSession

# Initialize Spark session
spark = SparkSession.builder.getOrCreate()

# =============================================================================
# Configuration
# =============================================================================
# Get storage account name from widget parameter
# This is passed automatically by the Databricks job or can be set manually
dbutils.widgets.text("storage_account_name", "", "Storage Account Name")
storage_account = dbutils.widgets.get("storage_account_name")

# Construct paths using ABFSS protocol (Azure Blob File System Secure)
# Bronze layer stores raw, unprocessed data
bronze_path = f"abfss://bronze@{storage_account}.dfs.core.windows.net/orders/"

# Source data location (sample data for demonstration)
source_path = "dbfs:/FileStore/sample_data/orders/"

# =============================================================================
# Data Ingestion
# =============================================================================
# Read CSV files from source
# header=true: Use first row as column names
df = (
    spark.read
    .option("header", "true")
    .csv(source_path)
)

# Write to Bronze layer in Delta format
# Append mode ensures we never lose historical data
# Delta format provides ACID transactions and versioning
df.write.mode("append").format("delta").save(bronze_path)

print(f"Successfully ingested {df.count()} records to Bronze layer")
