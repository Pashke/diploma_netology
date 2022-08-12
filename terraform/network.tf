resource "yandex_vpc_network" "default" {
  name = "net-${terraform.workspace}"
}

resource "yandex_vpc_subnet" "private-subnet" {
  name           = "private-subnet-${terraform.workspace}"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.default.id
  v4_cidr_blocks = ["192.168.10.0/24"]
  route_table_id = yandex_vpc_route_table.lab-rt-a.id
}

resource "yandex_vpc_subnet" "public-subnet" {
  name           = "public-subnet--${terraform.workspace}"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.default.id
  v4_cidr_blocks = ["172.16.0.0/24"]
}

resource "yandex_vpc_route_table" "lab-rt-a" {
  name       = "nat-instance-route"
  network_id = yandex_vpc_network.default.id
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = yandex_compute_instance.nginx.network_interface.0.ip_address
  }
}

#resource "yandex_vpc_subnet" "subnet-2" {
#  name           = "subnet2-${terraform.workspace}"
#  zone           = "ru-central1-b"
#  network_id     = yandex_vpc_network.default.id
#  v4_cidr_blocks = ["192.168.10.0/24"]
#}

resource "yandex_dns_zone" "zone" {
  name    = "blld-zone"
  zone    = "${var.domain}."
  public  = true
}

resource "yandex_dns_recordset" "rs" {
  for_each  = var.dns_list
  zone_id   = yandex_dns_zone.zone.id
  name      = "${each.value}blld.site."
  type      = "A"
  ttl       = 200
  data      = ["51.250.64.73"]
}