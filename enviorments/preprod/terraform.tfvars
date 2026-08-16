rgs = {
    rg1 = {
        name = "rg-preprod"
        location = "East Us"
    }
}
storage_accounts = {
    sa1 = {
        name = "stpreprod1121"
        resource_group_name = "rg-preprod"
        location = "East US"
        account_tier = "Standard"
        account_replication_type = "LRS"
    }
}