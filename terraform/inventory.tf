resource "local_file" "inventory" {
  content = <<-EOT
    [nginx]
    nginx ansible_host=${yandex_compute_instance.nginx.network_interface.0.nat_ip_address}
    [db01]
    db01 ansible_host=${yandex_compute_instance.mysql[0].network_interface.0.ip_address}
    [db02]
    db02 ansible_host=${yandex_compute_instance.mysql[1].network_interface.0.ip_address}
    [app]
    app ansible_host=${yandex_compute_instance.wordpress.network_interface.0.ip_address}
    [gitlab]
    gitlab ansible_host=${yandex_compute_instance.gitlab.network_interface.0.ip_address}
    [runner]
    runner ansible_host=${yandex_compute_instance.runner.network_interface.0.ip_address}

    [allhosts:children]
    nginx
    db01
    db02
    app
    gitlab
    runner

    [mysql:children]
    db01
    db02

    [gitlab_ci_runner:children]
    gitlab
    runner

    [db01:vars]
    master=1

    [db02:vars]
    master=0

    [gitlab_ci_runner:var]
    gitlab_password=slozHn1uPassw0rd
    gitlab_token=7376d76b-f9aa-439e-8df0-a386047c74c2

    [allhosts:vars]
    ansible_ssh_common_args='-o ControlMaster=auto -o ControlPersist=10m -o ProxyCommand="ssh -W %h:%p -q ubuntu@${yandex_compute_instance.nginx.network_interface.0.nat_ip_address}"'
    domain=${var.domain}
    ip_nginx=${yandex_compute_instance.nginx.network_interface.0.ip_address}
    ip_db01=${yandex_compute_instance.mysql[0].network_interface.0.ip_address}
    ip_db02=${yandex_compute_instance.mysql[1].network_interface.0.ip_address}
    ip_app=${yandex_compute_instance.wordpress.network_interface.0.ip_address}
    ip_gitlab=${yandex_compute_instance.gitlab.network_interface.0.ip_address}
    ip_runner=${yandex_compute_instance.runner.network_interface.0.ip_address}
    EOT
  filename        = "../ansible/inventory"
  file_permission = "0777"

  depends_on = [
    yandex_compute_instance.nginx,
    yandex_compute_instance.mysql,
    yandex_compute_instance.wordpress
  ]
}