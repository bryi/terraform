variable zone {
  description = "Zone"
  # Значение по умолчанию 
  default = "europe-west1-b"
}

variable public_key_path {
  # Описание переменной
  description = "~/.ssh/id_rsa.pub"
  default     = "~/.ssh/id_rsa.pub"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "app-1589892450"
}