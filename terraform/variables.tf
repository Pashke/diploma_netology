variable "yandex_cloud_id" {
  default = "b1grcpn8qi84n3n3a607"
}

variable "yandex_folder_id" {
  default = "b1gbgo924r85q278bg78"
}

variable "centos-7-base" {
  default = "fd88d14a6790do254kj7"
}

variable "ubuntu-2004" {
  default = "fd8ju9iqf6g5bcq77jns"
}

variable "ubuntu-nat" {
  default = "fd8phfma88csn6br814r"
}

variable "dns_list" {
  default =  {
    default       = ""
    WordPress     = "www."
    Gitlab        = "gitlab."
    Grafana       = "grafana."
    Prometheus    = "prometheus."
    AlertManager  = "alertmanager."
  }
}

variable "domain" {
  default = "blld.site"
}