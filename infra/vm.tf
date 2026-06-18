resource "yandex_compute_instance" "kittygram_vm" {
  name        = "kittygram-vm"
  platform_id = "standard-v2"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = "fd8vlv1vcjj3p69dvfop" # Ubuntu 22.04 LTS, уточни актуальный id
      size     = 15
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.kittygram_subnet.id
    security_group_ids = [yandex_vpc_security_group.kittygram_sg.id]
    nat                = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}" # или подставь публичный ключ из секретов
  }
}
