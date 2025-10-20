# Terraform-Based Service Principal Provisioning:

# Fetches metadata about the currently authenticated Azure AD client (you).
data "azuread_client_config" "current" {}

# Creates: An Azure AD application (the identity container for your SP)
resource "azuread_application" "main" {
  display_name = var.service_principal_name
  owners       = [data.azuread_client_config.current.object_id]
}

# Creates: The actual Service Principal linked to the app - Used for: AKS access, Terraform auth, pipeline integration
resource "azuread_service_principal" "main" {
  app_role_assignment_required = true
  client_id = azuread_application.main.client_id
  owners                       = [data.azuread_client_config.current.object_id]
}

# Creates: A client secret for the SP - or use in pipelines or Key Vault
resource "azuread_service_principal_password" "main" {
  service_principal_id = azuread_service_principal.main.id
}