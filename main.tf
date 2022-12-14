terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.13.0"
    }
  }
}

provider "docker" {}

resource "docker_image" "prometheus" {
  name         = "prom/prometheus"
  keep_locally = false
}

resource "docker_image" "grafana" {
  name = "grafana/grafana"
  keep_locally = false
}

resource "docker_image" "alert_manager" {
  name = "prom/alertmanager"
  keep_locally = false
}

resource "docker_container" "prometheus" {
  image = docker_image.prometheus.name
  name = "prometheus-container"
  ports {
    internal = 9090
    external = 9090
  }
}

resource "docker_container" "grafana" {
  image = docker_image.grafana.name
  name = "grafana-container"
  ports {
    internal = 3000
    external = 3000
  }
}

resource "docker_container" "alert_manager" {
  image = docker_image.alert_manager.name
  name = "alert_manager-container"
  ports {
    internal = 8100
    external = 8100
  }
}
