terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.0"
    }
  }

   backend "azurerm" {
    resource_group_name  = "<rg-think>"
    storage_account_name = "<rgthingstorageaccountgit>"
    container_name       = "<gitpracticesgthink>"
    key                  = "preprod.terraform.tfstate"
  }
}


provider "azurerm" {
  features {}
}
