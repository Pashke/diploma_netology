resource "local_file" "inventory" {
  content = <<-EOT
    [nginx]
    nginx ansible_host=${yandex_compute_instance.nginx.network_interface.0.nat_ip_address}
    [db01]
    db01 ansible_host=${yandex_compute_instance.mysql[0].network_interface.0.ip_address}
    [db02]
    db02 ansible_host=${yandex_compute_instance.mysql[1].network_interface.0.ip_address}

    [allhosts:children]
    nginx
    db01
    db02

    [mysql:children]
    db01
    db02

    [db01:vars]
    ansible_ssh_common_args='-o ControlMaster=auto -o ControlPersist=10m -o ProxyCommand="ssh -W %h:%p -q ubuntu@${yandex_compute_instance.nginx.network_interface.0.nat_ip_address}"'
    master=1

    [db02:vars]
    ansible_ssh_common_args='-o ControlMaster=auto -o ControlPersist=10m -o ProxyCommand="ssh -W %h:%p -q ubuntu@${yandex_compute_instance.nginx.network_interface.0.nat_ip_address}"'
    master=0

    [allhosts:vars]
    domain=${var.domain}
    ip_nginx=${yandex_compute_instance.nginx.network_interface.0.ip_address}
    ip_db01=${yandex_compute_instance.mysql[0].network_interface.0.ip_address}
    ip_db02=${yandex_compute_instance.mysql[1].network_interface.0.ip_address}
    EOT
  filename        = "../ansible/inventory"
  file_permission = "0777"

  depends_on = [
    yandex_compute_instance.nginx,
    yandex_compute_instance.mysql
  ]
}