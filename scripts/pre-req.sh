#!/bin/bash

# This script provisions:
# - Shared resource group
# - Two storage accounts (dev and stage)
# - Blob containers for Terraform state

RESOURCE_GROUP_NAME="terraform-state-rg"
LOCATION="eastus"
STAGE_SA_ACCOUNT="tfstagebacknb2025"
DEV_SA_ACCOUNT="tfdevbacknb2025"
CONTAINER_NAME="tfstate"

echo "🔧 Creating resource group: $RESOURCE_GROUP_NAME"
az group create --name "$RESOURCE_GROUP_NAME" --location "$LOCATION"

# Function to create storage account if not exists
create_storage_account() {
  local sa_name=$1
  echo "📦 Checking storage account: $sa_name"
  if az storage account show --name "$sa_name" --resource-group "$RESOURCE_GROUP_NAME" &>/dev/null; then
    echo "✅ Storage account $sa_name already exists. Skipping creation."
  else
    echo "🚀 Creating storage account: $sa_name"
    az storage account create \
      --name "$sa_name" \
      --resource-group "$RESOURCE_GROUP_NAME" \
      --location "$LOCATION" \
      --sku Standard_LRS \
      --encryption-services blob
  fi
}

# Function to create blob container using RBAC
create_blob_container() {
  local sa_name=$1
  echo "📂 Creating blob container in $sa_name"
  az storage container create \
    --name "$CONTAINER_NAME" \
    --account-name "$sa_name" \
    --auth-mode login
}

# Provision dev and stage storage accounts
create_storage_account "$STAGE_SA_ACCOUNT"
create_storage_account "$DEV_SA_ACCOUNT"

# Create blob containers
create_blob_container "$STAGE_SA_ACCOUNT"
create_blob_container "$DEV_SA_ACCOUNT"
