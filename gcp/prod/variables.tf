variable project {
  description = "Project ID"
  default     = "river-direction-258914"
}
variable region {
  description = "Region"
  # Значение по умолчанию 
  default = "europe-west1"
}
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
variable private_key_path {
  # Описание переменной
  description = "~/.ssh/id_rsa"
  default     = "~/.ssh/id_rsa"
}
variable disk_image {
  description = "reddit-base-1589887602"
}
variable db_disk_image {
  description = "Disk image for reddit db"
  default     = "db-1589892220"
}
variable app_disk_image {
  description = "Disk image for reddit app"
  default     = "app-1589892450"
}