output "internal_ip_address_vm_wordpress" {
  value = yandex_compute_instance.wordpress.network_interface.0.ip_address
}

output "internal_ip_address_vm_mssql" {
  value = yandex_compute_instance.mysql[*].network_interface.0.ip_address
}

output "internal_ip_address_vm_gitlab" {
  value = yandex_compute_instance.gitlab.network_interface.0.ip_address
}

output "internal_ip_address_vm_runner" {
  value = yandex_compute_instance.runner.network_interface.0.ip_address
}

output "internal_ip_address_vm_nat" {
  value = yandex_compute_instance.nginx.network_interface.0.ip_address
}

output "external_ip_address_vm_nat" {
  value = yandex_compute_instance.nginx.network_interface.0.nat_ip_address
}
