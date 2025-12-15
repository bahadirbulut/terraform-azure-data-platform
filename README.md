# Terraform Azure Data Platform

Author: **Bahadir Bulut**  
Company: **Nexence CommV**  
Role: Senior Data Engineer / Analytics Consultant  
Location: Belgium (EU)

This repository is a **reference / portfolio implementation** showcasing
how to provision a minimal, modular Azure data platform using Terraform.
It demonstrates common infrastructure-as-code patterns used in
enterprise data engineering environments, with a strong focus on
**cost awareness**, **observability**, and **clear separation of concerns**.

---

## Platform Components

This project provisions the following Azure resources:

- Resource Group
- ADLS Gen2 (Storage Account with bronze / silver / gold containers)
- Azure Key Vault
- Log Analytics Workspace
- Azure Databricks Workspace
- Azure Monitor Diagnostic Settings (for observability)
- *(Optional)* Auto-terminating Databricks cluster (conditional)

---

## What `terraform apply` creates (step by step)

When you run `terraform apply`, Terraform provisions the platform in the
following logical order:

### 1. Naming & Tagging (locals)
- Builds a name prefix based on `project` + `env` (e.g. `nexence-dev`)
- Generates a unified `common_tags` map:
  - project
  - env
  - owner
  - managed_by = terraform
  - plus any `extra_tags`
- These tags are applied consistently to supported Azure resources

### 2. Resource Group
- Creates a dedicated Azure Resource Group
- All platform resources are deployed inside this group

### 3. Log Analytics Workspace
- Creates a Log Analytics Workspace
- Serves as the centralized monitoring and observability foundation

### 4. Azure Key Vault
- Creates an Azure Key Vault for centralized secrets management
- No secrets or access policies are created in v1 (intentional)
- Wiring to compute is planned for a later iteration

### 5. ADLS Gen2 Storage
- Creates an Azure Storage Account with **Hierarchical Namespace enabled**
- Provisions containers (by default):
  - `bronze`
  - `silver`
  - `gold`
- This defines the storage layer only; no data ingestion happens automatically

### 6. Azure Databricks Workspace
- Creates an Azure Databricks Workspace (Azure control-plane resource)
- This is the workspace “shell” only:
  - No clusters
  - No jobs
  - No notebooks
- **No Databricks compute costs are incurred at this stage**

### 7. Diagnostic Settings (Observability)
- Attaches Azure Monitor Diagnostic Settings to:
  - ADLS Gen2 Storage Account
  - Azure Key Vault
  - Azure Databricks Workspace
- Logs and metrics are sent to Log Analytics, enabling:
  - Auditing
  - Troubleshooting
  - Cost & usage visibility

### 8. Optional: Databricks Cluster (Conditional)
- A small, cost-aware Databricks cluster is created **only if**
  `databricks_host` is provided
- Cluster characteristics:
  - Single worker
  - Small VM type
  - Auto-termination enabled (default: 20 minutes)
- This ensures compute costs are incurred **only intentionally**

### 9. Outputs
Terraform exposes useful outputs, including:
- Resource Group name
- ADLS account name & DFS endpoint
- Key Vault name
- Log Analytics workspace ID
- Databricks workspace URL

---

## Architecture (v1)

![Architecture Diagram](diagrams/architecture-v1.png)

The platform follows a simple, modular architecture:
- Storage layer: ADLS Gen2 with medallion-style containers
- Compute layer: Azure Databricks (workspace-only by default)
- Secrets management: Azure Key Vault
- Observability: Azure Monitor + Log Analytics
- Provisioning: Terraform (modular, environment-aware)

---

## Cost Awareness

This platform is designed to be **cheap by default**:

- Resource Group: €0
- ADLS Gen2: pay-per-GB stored (typically a few euros/month in dev)
- Key Vault: pay-per-operation (negligible at low usage)
- Log Analytics: minimal ingestion in dev
- Databricks:
  - Workspace alone: €0
  - Cluster: costs only while running and auto-terminates

By default, **no Databricks compute is created**, keeping costs near zero.

---

## Prerequisites

- Azure subscription
- Azure CLI authenticated (`az login`)
- Terraform >= 1.6

---

## How to Run (dev environment)

### Phase 1 — Infrastructure only (recommended first run)

```bash
cd environments/dev
terraform init
terraform plan
terraform apply
```

### Phase 2 — Enable Databricks compute (optional)

After Phase 1, retrieve the Databricks workspace URL from outputs and set
`databricks_host`. Then re-run `terraform apply` to create the
auto-terminating cluster.

---

## Copyright & Disclaimer

© 2025 **Bahadir Bulut** — **Nexence CommV**

This repository is provided for **reference purposes only**.
It does **not** contain any client data, proprietary configurations, or
confidential information.

All resource names, architectures, and configurations are generic and
intended to demonstrate infrastructure-as-code patterns only.

Use at your own risk.
