# Terraform Azure Data Platform (Portfolio)

This repo provisions a minimal Azure data platform using Terraform:
- Resource Group
- ADLS Gen2 (Storage Account + containers: bronze/silver/gold)
- Key Vault
- Log Analytics Workspace
- Azure Databricks Workspace

## Architecture (v1)
- Landing data in ADLS Gen2 containers (bronze/silver/gold)
- Compute via Azure Databricks
- Secrets intended for Key Vault (wiring added in v2)
- Monitoring baseline via Log Analytics

## Prerequisites
- Azure subscription
- Azure CLI logged in: `az login`
- Terraform >= 1.6

## How to run (dev)
```bash
cd environments/dev
terraform init
terraform plan
terraform apply
