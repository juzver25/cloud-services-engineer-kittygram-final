resource "yandex_vpc_security_group" "kittygram_sg" {
  name       = "kittygram-sg"
  network_id = yandex_vpc_network.kittygram_network.id

  ingress {
    protocol       = "TCP"
    description    = "SSH"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "HTTP"
    port           = 80   # порт gateway (если приложение слушает 80)
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all outbound"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}