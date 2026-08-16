rgs = {
    rg1 = {
        name = "rg-prod"
        location = "East Us"
    }
}
storage_accounts = {
    sa1 = {
        name = "stprod1121"
        resource_group_name = "rg-prod"
        location = "East US"
        account_tier = "Standard"
        account_replication_type = "LRS"
    }
}