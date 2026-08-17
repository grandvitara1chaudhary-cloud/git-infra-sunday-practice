<div align="center">

# ☁️ Azure Infrastructure as Code (IaC) with Terraform 🚀

<p align="center">
  <strong>Modular • Scalable • Multi-Environment • Production-Ready</strong>
</p>

[![Terraform](https://img.shields.io/badge/Terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)](https://azure.microsoft.com/)
[![IaC](https://img.shields.io/badge/Infrastructure-as--Code-blue?style=for-the-badge&logo=cloud)](https://en.wikipedia.org/wiki/Infrastructure_as_code)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg?style=for-the-badge)](https://github.com/)

---

### 🌟 Fast Navigation

[📌 Overview](#-project-overview) • [🏗️ Architecture](#️-architecture--flow) • [📦 Modules](#-modular-components) • [🌍 Environments](#-environments-breakdown) • [🚀 Deployment Guide](#-step-by-step-deployment-guide) • [⚙️ Variables](#️-variable-configuration) • [🛡️ Best Practices](#-best-practices)

---

</div>

## 📌 Project Overview

> [!NOTE]
> **What is this repository?**  
> This project is a production-grade **Terraform Infrastructure as Code (IaC)** blueprint for provisioning Azure resources. It implements the **DRY (Don't Repeat Yourself)** principle by decoupling **reusable modules** from **environment-specific values**.

### 💎 Key Highlights at a Glance

| Feature | Description | Benefit |
| :--- | :--- | :--- |
| 🧩 **Modular Design** | Self-contained resource modules | Plug-and-play reusability across any project |
| 🔁 **Dynamic `for_each`** | Resource provisioning powered by map loops | Provision 1 or 100+ resources without changing code |
| 🧪 **Multi-Stage Environments** | Dedicated `preprod` and `prod` configurations | Test safely in staging before touching production |
| 🔒 **State Isolation** | Separate state tracking per environment | Prevents accidental blast radius across environments |

---

## 🏗️ Architecture & Flow

### 🔄 Provisioning Workflow

```
   ┌──────────────────────────────────────────────────────────┐
   │                  🌍 Environment Configs                  │
   │   📁 enviorments/preprod          📁 enviorments/prod     │
   │   └─ terraform.tfvars             └─ terraform.tfvars    │
   └───────────────┬───────────────────────────┬──────────────┘
                   │  (Inputs: Names, Regions) │
                   ▼                           ▼
   ┌──────────────────────────────────────────────────────────┐
   │                  📦 Reusable Modules                     │
   │   📁 modules/azurerm_resource_group                      │
   │   📁 modules/azurerm_storage_account                     │
   └─────────────────────────────┬────────────────────────────┘
                                 │  (Provisions via AzureRM)
                                 ▼
   ┌──────────────────────────────────────────────────────────┐
   │                 ☁️ Microsoft Azure Cloud                 │
   │   🔹 Resource Groups:  [rg-preprod]  /  [rg-prod]        │
   │   🔹 Storage Accounts: [stpreprod..] /  [stprod..]       │
   └──────────────────────────────────────────────────────────┘
```

---

## 🗂️ Directory Structure Explained

```plaintext
git-infra-sunday-practice/
│
├── 📁 enviorments/                         # 🌍 Environment root modules
│   │
│   ├── 📁 preprod/                         # 🧪 Pre-Production Environment
│   │   ├── 📄 main.tf                      # ➔ Calls modules with preprod parameters
│   │   ├── 📄 provider.tf                  # ➔ Defines AzureRM provider & version (5.0)
│   │   ├── 📄 terraform.tfvars             # ➔ Preprod actual data values
│   │   └── 📄 variable.tf                  # ➔ Variable definitions for preprod
│   │
│   └── 📁 prod/                            # 🚀 Production Environment
│       ├── 📄 main.tf                      # ➔ Calls modules with prod parameters
│       ├── 📄 provider.tf                  # ➔ Defines AzureRM provider & version (5.0)
│       ├── 📄 terraform.tfvars             # ➔ Prod actual data values
│       └── 📄 variable.tf                  # ➔ Variable definitions for prod
│
├── 📁 modules/                             # 📦 Core Reusable Modules (DRY)
│   │
│   ├── 📁 azurerm_resource_group/          # 📦 Resource Group Module
│   │   ├── 📄 main.tf                      # ➔ azurerm_resource_group with for_each
│   │   └── 📄 variable.tf                  # ➔ Map input variable declaration
│   │
│   └── 📁 azurerm_storage_account/         # 📦 Storage Account Module
│       ├── 📄 main.tf                      # ➔ azurerm_storage_account with for_each
│       └── 📄 variable.tf                  # ➔ Map input variable declaration
│
├── 📄 .gitignore                           # 🚫 Excludes .terraform, *.tfstate, crash logs
└── 📄 README.md                            # 📖 Project documentation
```

---

## 📦 Modular Components

### 1️⃣ Module: `azurerm_resource_group`
📍 **Path**: `modules/azurerm_resource_group`

| Parameter | Type | Required | Description | Example |
| :--- | :---: | :---: | :--- | :--- |
| `name` | `string` | ✅ Yes | Name of the Azure Resource Group | `"rg-preprod"` |
| `location` | `string` | ✅ Yes | Azure Region to deploy in | `"East US"` |

---

### 2️⃣ Module: `azurerm_storage_account`
📍 **Path**: `modules/azurerm_storage_account`

| Parameter | Type | Required | Description | Example |
| :--- | :---: | :---: | :--- | :--- |
| `name` | `string` | ✅ Yes | Globally unique storage name (3-24 lowercase/numbers) | `"stpreprod1121"` |
| `resource_group_name` | `string` | ✅ Yes | Name of parent Resource Group | `"rg-preprod"` |
| `location` | `string` | ✅ Yes | Target Azure Region | `"East US"` |
| `account_tier` | `string` | ✅ Yes | Performance Tier (`Standard` / `Premium`) | `"Standard"` |
| `account_replication_type` | `string` | ✅ Yes | Redundancy type (`LRS`, `GRS`, `ZRS`, `RAGRS`) | `"LRS"` |

---

## 🌍 Environments Breakdown

> [!TIP]
> Each environment operates in total isolation with its own variable values:

| Configuration Key | 🧪 `preprod` (Staging / QA) | 🚀 `prod` (Production) |
| :--- | :--- | :--- |
| **Directory** | `enviorments/preprod/` | `enviorments/prod/` |
| **Resource Group** | `rg-preprod` | `rg-prod` |
| **Storage Account** | `stpreprod1121` | `stprod1121` |
| **Location** | `East US` | `East US` |
| **Account Tier** | `Standard` | `Standard` |
| **Replication Type** | `LRS` (Locally Redundant) | `LRS` (Locally Redundant) |

---

## 📋 Prerequisites Checklist

Before running any commands, make sure you have:

- [x] 🛠️ **Terraform CLI** installed (`v1.0+`) ➔ [Download](https://www.terraform.io/downloads.html)
- [x] ☁️ **Azure CLI (`az`)** installed ➔ [Download](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- [x] 🔑 **Active Azure Subscription** with Contributor or Owner role

---

## 🚀 Step-by-Step Deployment Guide

```
  Step 1         Step 2        Step 3        Step 4        Step 5        Step 6
┌────────┐    ┌────────┐    ┌────────┐    ┌────────┐    ┌────────┐    ┌────────┐
│ az     │ ➔  │ cd     │ ➔  │ terra- │ ➔  │ terra- │ ➔  │ terra- │ ➔  │ terra- │
│ login  │    │ env    │    │ form   │    │ form   │    │ form   │    │ form   │
│        │    │        │    │ init   │    │ validate│   │ plan   │    │ apply  │
└────────┘    └────────┘    └────────┘    └────────┘    └────────┘    └────────┘
```

### 🔹 Step 1: Azure Authentication
Log into your Azure account:
```bash
az login
```
*(Optional) If you have multiple subscriptions, set your target subscription:*
```bash
az account set --subscription "<YOUR_SUBSCRIPTION_ID_OR_NAME>"
```

---

### 🔹 Step 2: Choose Target Environment
Select the environment you want to manage:

- **For Pre-Production:**
  ```bash
  cd enviorments/preprod
  ```
- **For Production:**
  ```bash
  cd enviorments/prod
  ```

---

### 🔹 Step 3: Initialize Terraform
Downloads the `hashicorp/azurerm` provider (v5.0) and loads local modules:
```bash
terraform init
```

> [!NOTE]
> Run `terraform init` whenever you add a new module or change provider configs.

---

### 🔹 Step 4: Validate and Format Code
Check code syntax and format for clean styling:
```bash
# Auto-format all files
terraform fmt -recursive

# Validate syntax and arguments
terraform validate
```

---

### 🔹 Step 5: Generate Execution Plan (Dry Run)
Preview all resources that will be created, modified, or destroyed:
```bash
terraform plan
```

---

### 🔹 Step 6: Apply and Deploy Infrastructure
Deploy the resources into your Azure cloud:
```bash
terraform apply
```
> [!IMPORTANT]
> When prompted with `Do you want to perform these actions?`, type **`yes`** and press Enter.

---

## ⚙️ Variable Configuration

You can easily add, update, or remove resources by editing `terraform.tfvars`:

```hcl
# Example: enviorments/prod/terraform.tfvars

# 🔹 1. Resource Groups Map
rgs = {
  rg1 = {
    name     = "rg-prod-main"
    location = "East US"
  }
  rg2 = {
    name     = "rg-prod-secondary"
    location = "Central US"
  }
}

# 🔹 2. Storage Accounts Map
storage_accounts = {
  sa1 = {
    name                     = "stprodappdata01"
    resource_group_name      = "rg-prod-main"
    location                 = "East US"
    account_tier             = "Standard"
    account_replication_type = "GRS"
  }
  sa2 = {
    name                     = "stprodbackups01"
    resource_group_name      = "rg-prod-secondary"
    location                 = "Central US"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}
```

---

## 🧹 Cleanup & Teardown

> [!WARNING]
> Running `terraform destroy` will permanently delete all cloud resources managed in this environment directory.

```bash
# 1. Switch to environment folder
cd enviorments/preprod   # or enviorments/prod

# 2. Execute destruction
terraform destroy
```
*Type `yes` when prompted to confirm.*

---

## 🛡️ Best Practices

| Category | Recommendation | Why It Matters |
| :--- | :--- | :--- |
| 🔐 **State Security** | Use Azure Blob remote backend with state locking | Prevents concurrent run race conditions & state corruption |
| 🏷️ **Tagging** | Add `Environment`, `Owner`, and `CostCenter` tags | Enables cloud cost allocation and resource tracking |
| 🚫 **Secrets** | Never commit `.tfstate` or `.tfvars` containing secrets | Protects infrastructure from security leaks |
| 🔄 **CI/CD** | Implement GitHub Actions or Azure DevOps pipelines | Automates linting, validation, and peer-reviewed plans |

---

## 💡 Quick Command Reference

```bash
# Initialize working directory
terraform init

# Validate configuration files
terraform validate

# Reformat code to standard style
terraform fmt

# Show planned changes
terraform plan

# Apply infrastructure changes
terraform apply -auto-approve

# Destroy all managed infrastructure
terraform destroy -auto-approve
```

---

<div align="center">

### 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Made with ❤️ • **Azure Infrastructure as Code**

</div>