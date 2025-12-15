# Terraform Azure Data Platform (Portfolio)

Author: **Bahadir Bulut**  
Company: **Nexence CommV**  
Role: Senior Data Engineer / Analytics Consultant  
Location: Belgium (EU)

This repository is a **portfolio / reference implementation** showcasing
how to provision a minimal, modular Azure data platform using Terraform.
It demonstrates common infrastructure-as-code patterns used in
enterprise data engineering environments.

---

## Platform Components

This project provisions the following Azure resources:
- Resource Group
- ADLS Gen2 (Storage Account with bronze / silver / gold containers)
- Azure Key Vault
- Log Analytics Workspace
- Azure Databricks Workspace

---

## Architecture (v1)

- Raw and curated data storage in ADLS Gen2 (medallion-style containers)
- Compute layer via Azure Databricks
- Centralized secrets management via Key Vault (integration added in v2)
- Monitoring baseline via Log Analytics

---

## Prerequisites

- Azure subscription
- Azure CLI authenticated (`az login`)
- Terraform >= 1.6

---

## How to Run (dev environment)

```bash
cd environments/dev
terraform init
terraform plan
terraform apply
```

## Copyright & Disclaimer

© 2025 **Bahadir Bulut** — **Nexence CommV**

This repository is provided for **educational and portfolio purposes only**.
It does **not** contain any client data, proprietary configurations, or
confidential information.

All resource names, architectures, and configurations are generic and
intended to demonstrate infrastructure-as-code patterns only.

Use at your own risk.
