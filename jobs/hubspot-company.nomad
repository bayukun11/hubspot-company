job "hubspot-company" {
  datacenters = ["dc1"]
  type        = "service"

  group "app-group" {
    count = 1

    network {
      port "http" {
        static = 5104
        to     = 5104
      }
    }

    service {
      name     = "hubspot-company-service"
      port     = "http"
      provider = "consul"

      check {
        type     = "http"
        path     = "/scan/health"
        interval = "10s"
        timeout  = "2s"
      }
    }

    task "web" {
      driver = "docker"

      config {
        image = "bayukun11/hubspot-company:latest"
        ports = ["http"]
      }

      resources {
        cpu    = 250
        memory = 256
      }
    }
  }
}
