resource "azurerm_resource_group" "rg" {
  name = "DevOps-rg"
  location = var.available_zones[1]
}

resource "azurerm_storage_account" "storage" {
  name = "qrcode-storage"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  account_tier = "Standard"
  account_replication_type = "LRS"
  
}

resource "azurerm_service_plan" "DevSerPlan" {
  name = "Devservice-plan"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  sku_name = "B1"
  os_type = "Linux"
}

resource "azurerm_linux_function_app" "functionapp" {
  name = "functionapp"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  storage_account_name       = azurerm_storage_account.storage.name
  storage_account_access_key = azurerm_storage_account.storage.primary_access_key
  service_plan_id = azurerm_service_plan.DevSerPlan.id
  site_config {
    application_stack {
      node_version = 18
    }
  }
  
}