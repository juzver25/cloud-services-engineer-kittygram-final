terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

backend "s3" {
  endpoint   = "https://storage.yandexcloud.net"
  bucket     = "kitty-tfstate"
  region     = "ru-central1"
  key        = "tf-state.tfstate"

  skip_region_validation      = true
  skip_credentials_validation = true

}
}

provider "yandex" {
  service_account_key_file = "authorized_key.json"
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = "ru-central1-a"
}