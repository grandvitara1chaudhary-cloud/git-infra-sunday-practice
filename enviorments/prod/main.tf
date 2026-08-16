
module "resource_group" {
    source = "../../module/azurerm_resource_group"
    resource_group = var.rgs
      
}
module "storage_account" {
    source = "../../module/azurerm_storage_account"
    storage_accounts = var.storage_accounts
      
}