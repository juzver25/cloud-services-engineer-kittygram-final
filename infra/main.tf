resource "yandex_vpc_network" "main" {
  name = "kittygram-network"
}

resource "yandex_vpc_subnet" "main" {
  name           = "kittygram-subnet"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = ["10.10.0.0/24"]
}

resource "yandex_vpc_security_group" "main" {
  name        = "kittygram-sg"
  network_id  = yandex_vpc_network.main.id

  ingress {
    description = "SSH"
    protocol    = "TCP"
    port        = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP (Kittygram)"
    protocol    = "TCP"
    port        = 8000
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Весь исходящий трафик"
    protocol    = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 65535
  }
}

resource "yandex_storage_bucket" "terraform_state" {
  bucket = var.s3_bucket_name
  acl    = "private"
}

resource "yandex_compute_instance" "vm" {
  name        = var.vm_name
  platform_id = "standard-v3"
  zone        = var.default_zone

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = 20
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.main.id
    security_group_ids = [yandex_vpc_security_group.main.id]
    nat                = true  
  }

  metadata = {
    ssh-keys = "ubuntu:${var.public_ssh_key}"
    user-data = <<-EOF
      package_update: true
      package_upgrade: true
      packages:
        - docker.io
        - docker-compose-plugin
      runcmd:
        - systemctl enable docker
        - systemctl start docker
        - usermod -aG docker ubuntu
        - curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        - chmod +x /usr/local/bin/docker-compose
        - su - ubuntu -c "git clone https://github.com/your-repo/kittygram.git /home/ubuntu/kittygram"
        - cd /home/ubuntu/kittygram && docker-compose up -d
    EOF
  }
}

data "yandex_compute_image" "ubuntu" {
  family = var.vm_image_family
}