#output "internal_ip_address_vm_wordpress" {
#  value = yandex_compute_instance.wordpress.network_interface.0.ip_address
#}

output "internal_ip_address_vm_mssql" {
  value = yandex_compute_instance.mysql[*].network_interface.0.ip_address
}

#output "internal_ip_address_vm_3" {
#  value = yandex_compute_instance.node03.network_interface.0.ip_address
#}

output "internal_ip_address_vm_nat" {
  value = yandex_compute_instance.nginx.network_interface.0.ip_address
}

output "external_ip_address_vm_nat" {
  value = yandex_compute_instance.nginx.network_interface.0.nat_ip_address
}

#output "jump_config" {
#  value = <<-EOT
#  StrictHostKeyChecking no
#  Host ${yandex_compute_instance.mssql[0].network_interface.0.ip_address} ${yandex_compute_instance.mssql[1].network_interface.0.ip_address}
#    ProxyJump ubuntu@${yandex_compute_instance.nat.network_interface.0.nat_ip_address}
#  EOT
#}
