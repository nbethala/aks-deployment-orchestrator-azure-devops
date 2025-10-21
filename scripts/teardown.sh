#!/bin/bash

# This script tears down:
# - Blob containers
# - Storage accounts (dev and stage)
# - Shared resource group

RESOURCE_GROUP_NAME="terraform-state-rg"
STAGE_SA_ACCOUNT="tfstagebacknb2025"
DEV_SA_ACCOUNT="tfdevbacknb2025"
CONTAINER_NAME="tfstate"

# Function to delete blob container if it exists
delete_blob_container() {
  local sa_name=$1
  echo "📂 Checking blob container in $sa_name"
  if az storage container show --name "$CONTAINER_NAME" --account-name "$sa_name" --auth-mode login &>/dev/null; then
    echo "🧹 Deleting blob container: $CONTAINER_NAME from $sa_name"
    az storage container delete --name "$CONTAINER_NAME" --account-name "$sa_name" --auth-mode login
  else
    echo "⚠️ Blob container $CONTAINER_NAME not found in $sa_name. Skipping."
  fi
}

# Function to delete storage account if it exists
delete_storage_account() {
  local sa_name=$1
  echo "📦 Checking storage account: $sa_name"
  if az storage account show --name "$sa_name" --resource-group "$RESOURCE_GROUP_NAME" &>/dev/null; then
    echo "🔥 Deleting storage account: $sa_name"
    az storage account delete --name "$sa_name" --resource-group "$RESOURCE_GROUP_NAME" --yes
  else
    echo "⚠️ Storage account $sa_name not found. Skipping."
  fi
}

# Delete blob containers
delete_blob_container "$STAGE_SA_ACCOUNT"
delete_blob_container "$DEV_SA_ACCOUNT"

# Delete storage accounts
delete_storage_account "$STAGE_SA_ACCOUNT"
delete_storage_account "$DEV_SA_ACCOUNT"

# Delete resource group
echo "🧨 Deleting resource group: $RESOURCE_GROUP_NAME"
az group delete --name "$RESOURCE_GROUP_NAME" --yes --no-wait
