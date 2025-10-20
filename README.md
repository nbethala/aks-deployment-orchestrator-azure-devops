# AKS Deployment Orchestrator with Terraform and Azure DevOps

📦 Project Overview
This project automates the provisioning of secure, autoscaling Azure Kubernetes Service (AKS) clusters across isolated dev and staging environments using modular Terraform and Azure DevOps pipelines. It solves the business problem of inconsistent cloud deployments by enabling reproducible infrastructure, secure credential management, and lifecycle hygiene — all critical for scaling platform operations in production.

✅ What’s Been Set Up So Far
1. Terraform Backend Provisioning
Scripted setup (pre-req.sh) creates:

Shared resource group

Two storage accounts (dev + staging)

Blob containers for remote state

Enables reproducible infrastructure with cost controls per environment

2. Service Principal Module
Provisions an Azure AD application and service principal

Generates client secret and stores it securely in Key Vault

Assigns Contributor role at subscription scope

3. Key Vault Module
Premium Key Vault with RBAC authorization

Stores SP credentials and SSH keys

Soft delete and purge protection enabled

4. AKS Cluster Module
Zonal, autoscaling AKS cluster with VMSS node pool

Injects SP credentials and SSH public key securely

Uses latest stable Kubernetes version per region

Network profile configured with Azure CNI and Standard Load Balancer

5. Environment-Specific Terraform Setups
Separate folders for dev/ and staging/:

Each has its own main.tf, terraform.tfvars, and backend.tf

Secrets injected via Azure DevOps variable groups

Local kubeconfig output for validation and Helm integration

🧠 Business Problem Solved
Manual cloud provisioning is error-prone, inconsistent, and hard to scale. This project replaces ad hoc deployment with a fully automated, modular Terraform setup that provisions AKS clusters, service principals, and secure credential storage — all wired into CI/CD pipelines and lifecycle-aware teardown strategies.

💼 Business Impact
🚀 Accelerates time-to-deploy for dev and staging environments

🔐 Reduces operational risk with RBAC and Key Vault integration

💰 Improves cost control via environment isolation and teardown automation

🔁 Enables reproducibility and auditability across teams

🛠️ Supports incident response with version-controlled infrastructure

📚 Next Steps
Add observability stack (Prometheus, Grafana, Alertmanager)

Automate teardown with dry-run safeguards