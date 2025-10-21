
pre-req.sh
Creates resource group

Creates storage accounts (tfdevbackend2025, tfstagebackend2025)

Creates blob containers (tfstate)

Uses --auth-mode login for RBAC-safe access

🔹 create.yml
Runs terraform init using the backend

Provisions AKS, Key Vault, SP, etc.

🔹 destroy.yml
Destroys Terraform-managed resources

Leaves backend untouched

🔹 teardown.sh
Deletes blob containers

Deletes storage accounts

Deletes resource group