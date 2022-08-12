resource "yandex_compute_instance" "nginx" {
  name                      = "nginx-${terraform.workspace}"
  zone                      = "ru-central1-a"
  hostname                  = "${var.domain}"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.ubuntu-nat
      name     = "root-nginx-${terraform.workspace}"
      type     = "network-nvme"
      size     = "20"
    }
  }

  network_interface {
    subnet_id       = yandex_vpc_subnet.public-subnet.id
    nat             = true
    nat_ip_address  = "51.250.64.73"
    ip_address      = "172.16.0.32"
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
#-----------------------------------------------------------------------------------------------------------------------
resource "yandex_compute_instance" "mysql" {
  count                     = 2
  name                      = "db0${count.index+1}"
  zone                      = "ru-central1-a"
  hostname                  = "db0${count.index+1}.${var.domain}"
  allow_stopping_for_update = true

  resources {
    cores  = 4
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = var.ubuntu-2004
      name     = "root-mssql-0${count.index+1}-${terraform.workspace}"
      type     = "network-nvme"
      size     = "20"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private-subnet.id
    ip_address  = "${count.index == 0 ? "192.168.10.14" : "192.168.10.18"}"
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
#-----------------------------------------------------------------------------------------------------------------------
#resource "yandex_compute_instance" "wordpress" {
#  name                      = "wordpress-${terraform.workspace}"
#  zone                      = "ru-central1-a"
#  hostname                  = "${terraform.workspace == "prod" ? "" : "${terraform.workspace}."}node01.blld.site"
#  allow_stopping_for_update = true
#
#  resources {
#    cores  = 2
#    memory = 2
#  }
#
#  boot_disk {
#    initialize_params {
#      image_id = var.ubuntu-2004
#      name     = "root-wordpress-${terraform.workspace}"
#      type     = "network-nvme"
#      size     = "20"
#    }
#  }
#
#  network_interface {
#    subnet_id = yandex_vpc_subnet.private-subnet.id
##    nat       = true
#  }
#
#  metadata = {
#    ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
#  }
#}
