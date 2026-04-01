variable "cloud_id" {
  description = "Идентификатор облака"
  type        = string
}

variable "folder_id" {
  description = "Идентификатор каталога"
  type        = string
}

variable "default_zone" {
  description = "Зона доступности по умолчанию"
  type        = string
  default     = "ru-central1-a"
}

variable "service_account_key_file" {
  description = "файл c ключом сервисного аккаунта"
  type        = string
}

variable "vm_name" {
  description = "Имя виртуальной машины"
  type        = string
  default     = "kittygram-vm"
}

variable "vm_image_family" {
  description = "Семейство образа для ВМ (Ubuntu 22.04 LTS)"
  type        = string
  default     = "ubuntu-2204-lts"
}

variable "public_ssh_key" {
  description = "Публичный SSH-ключ для доступа к ВМ"
  type        = string
  sensitive   = true
}

variable "s3_access_key" {
  description = "статический ключ сервисного аккаунта"
  type        = string
  sensitive   = true
}

variable "s3_secret_key" {
  description = "Секретный ключ для S3-бакета"
  type        = string
  sensitive   = true
}

variable "s3_bucket_name" {
  description = "Имя бакета для хранения state Terraform"
  type        = string
}