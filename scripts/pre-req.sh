#!/bin/bash

# This script provisions : 
# shared resource group
# Two storage accounts (for dev and stage)
# Blob containers to hold Terraform state files ( for dev and stage)

RESOURCE_GROUP_NAME=terraform-state-rg
STAGE_SA_ACCOUNT=tfstagebackend2025
DEV_SA_ACCOUNT=tfdevbackend2025
CONTAINER_NAME=tfstate


# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location eastus

# Create storage account for staging environment
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STAGE_SA_ACCOUNT --sku Standard_LRS --encryption-services blob

# Create storage account for dev environment
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $DEV_SA_ACCOUNT --sku Standard_LRS --encryption-services blob

# Create blob container for staging environment
az storage container create --name $CONTAINER_NAME --account-name $STAGE_SA_ACCOUNT

# Create blob container for dev environment
az storage container create --name $CONTAINER_NAME --account-name $DEV_SA_ACCOUNT