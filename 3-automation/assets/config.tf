terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker"
        }
        datadog = {
            source = "datadog/datadog"
        }
    }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "datadog_image" {
  name = "datadog/agent:7.21.1"
}

resource "datadog_container" "datadog_container" {
  name = "datadog-agent"
  image = "${docker_image.datadog_image.name}"
}

resource "docker_container" "redis_container" {
  name = "redis-session-cache"
  image = "${docker_image.redis_image.name}"
}

resource "docker_image" "redis_image" {
  name = "redis:6.2-alpine"
}

resource "docker_container" "redis_container" {
  name = "redis-session-cache"
  image = "${docker_image.redis_image.name}"
}

provider "datadog" {}

resource "datadog_monitor" "redis_cpu" {
  name = "Average Redis System CPU Usage"
  type = "metric alert"
  message = "Uh oh. Redis is burning up the CPU! @steve.calnan@datadoghq.com"
  
  query = "avg(last_1h):avg:redis.cpu.sys{env:dd201,service:redis-session-cache} > 1"

  monitor_thresholds {
    warning           = ".8"
    warning_recovery  = ".6"
    critical          = 1
    critical_recovery = ".8"
  }

  tags = ["env:dd201", "service:redis-session-cache"]
}
