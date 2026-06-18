variable "vpc_name" {
  description = "VPC Name"
  type        = string
  default     = "infra-network"
}

variable "net_cidr" {
  description = "Subnet structure"
  type = list(object({
    name   = string
    zone   = string
    prefix = string
  }))

  default = [
    { name = "infra-subnet-a", zone = "ru-central1-a", prefix = "10.129.1.0/24" },
    { name = "infra-subnet-b", zone = "ru-central1-b", prefix = "10.130.1.0/24" },
    { name = "infra-subnet-d", zone = "ru-central1-d", prefix = "10.131.1.0/24" },
  ]
}

variable "vm_1_name" {
  type        = string
  default     = "vm-kittygram"
}

variable "aws_region" {
  description = "AWS Region name"
  type        = string
  default = "ru-central1"
}

variable "ssh_key" {
  description = "SSH public key for VM access"
  type        = string
}

variable "cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
}

variable "zone" {
  description = "Зона доступности по умолчанию"
  type        = string
  default     = "ru-central1-a"
}

variable "platform_id" {
  description = "Платформа ВМ"
  type        = string
  default     = "standard-v2"
}

variable "image_family" {
  description = "Семейство образа ОС"
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "cores" {
  description = "Количество ядер CPU"
  type        = number
  default     = 2
}

variable "memory" {
  description = "Объем RAM (ГБ)"
  type        = number
  default     = 4
}

variable "disk_type" {
  description = "Тип диска (network-hdd, network-ssd)"
  type        = string
  default     = "network-ssd"
}

variable "disk_size" {
  description = "Размер диска (ГБ)"
  type        = number
  default     = 40
}

variable "nat" {
  description = "Назначать публичный IP"
  type        = bool
  default     = true
}

variable "default_zone" {
  description = "Yandex Cloud default zone"
  type        = string
  default     = "ru-central1-a"
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket for terraform state"
  type        = string
}

variable "vm_image_family" {
  description = "OS image family for the VM"
  type        = string
  default     = "ubuntu-2204-lts"
}