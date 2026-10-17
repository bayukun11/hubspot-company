job "hubspot-company" {
  datacenters = ["dc1"]
  type        = "service"

  group "app-group" {
    count = 1

    network {
      port "http" {
        # Menentukan port static agar mudah diakses sesuai requirement Task 2
        static = 5000
        to     = 5000
      }
    }

    service {
      name     = "hubspot-company-service"
      port     = "http"
      provider = "consul"

      # Health check HTTP yang akan didaftarkan ke Consul
      check {
        type     = "http"
        path     = "/"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "web" {
      driver = "docker"

      config {
        # Mengambil image yang di-build oleh GitHub Actions
        image = "bayukun11/hubspot-company:latest"
        ports = ["http"]
      }

      # Batasan resource CPU dan RAM sesuai requirement Task 2
      resources {
        cpu    = 250
        memory = 256
      }
    }
  }
}
