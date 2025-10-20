

## Step 1: Backend provisioning - storage, blob containers, resource group for dev & stage.
aks-deployment-orchestrator/scripts/pre-req.sh

scripts/pre-req.sh -  provisions isolated Terraform backends for dev and stage environments using Azure CLI.

## Step 2: Terraform-Based Provisioning 
 ### Module Service Principal : 

### Module aks 
This module provisions a zonal, autoscaling AKS cluster with secure SP integration and SSH key management via Key Vault.

### Module keyvault
This module provisions a premium Azure Key Vault with RBAC access control, soft delete retention, and secure storage for AKS credentials and SSH keys. It integrates with Azure DevOps pipelines for secret injection and lifecycle hygiene.

## Step 3: dev - Terraform Setup
This dev environment provisions a secure AKS cluster using modular Terraform, with SP credentials stored in Key Vault and RBAC-managed access. It supports reproducible infrastructure and lifecycle hygiene for CI/CD-driven deployments.

### terraform.tfvars: 
defines environment-specific values for the dev AKS orchestrator setup, enabling reproducible infrastructure across stages. Secrets are injected securely via Key Vault and pipelines.

Note: do not hardcode your SUB_ID=subscription id. Instead Use Variable Groups in Azure Devops to inject into CI/CD pipeline.

Go to Azure DevOps → Pipelines → Library - create a variable  group: TerraformSecrets

## Step 4: staging - Terraform Setup
The staging environment mirrors the dev setup using modular Terraform. It provisions a zonal AKS cluster with secure SP and Key Vault integration, enabling isolated testing before production rollout. Secrets are injected securely via Azure DevOps variable groups.

## Step 5: CI/CD azure pipelines setup 
This repo includes CI/CD pipelines for provisioning and tearing down AKS infrastructure using Terraform. Secrets are injected securely via Azure DevOps variable groups, and remote state is managed per environment for reproducibility and cost control.

create.yaml
destroy.yaml
