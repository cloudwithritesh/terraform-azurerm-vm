output "vm_id" { value = azurerm_linux_virtual_machine.this.id }
output "resource_group_name" { value = azurerm_resource_group.this.name }
output "private_ip" { value = azurerm_network_interface.this.private_ip_address }
output "admin_username" { value = var.admin_username }

output "ssh_private_key" {
  value     = tls_private_key.ssh.private_key_pem
  sensitive = true
}
