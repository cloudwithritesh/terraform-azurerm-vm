# terraform-azurerm-vm

No-code ready module: deploys an Ubuntu 24.04 Linux VM (private, SSH-key auth) with its own
resource group, VNet and subnet in Azure.

| Input | Description |
|-------|-------------|
| vm_name | Short name, 3-30 chars (lowercase, numbers, hyphens) |
| environment | dev / test / prod |
| location | Azure region |
| vm_size | VM SKU |
| admin_username | Default `azureuser` |

Outputs: vm_id, resource_group_name, private_ip, admin_username, ssh_private_key (sensitive).
