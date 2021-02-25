variable zone {
  description = "Zone"
  # Значение по умолчанию 
  default = "europe-west1-b"
}

variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "db-1589892220"
}

variable public_key_path {
  # Описание переменной
  description = "~/.ssh/id_rsa.pub"
  default     = "~/.ssh/id_rsa.pub"
}