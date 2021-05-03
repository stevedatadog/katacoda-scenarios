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

variable "datadog_api_key" {
    type = string
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "datadog_image" {
  name = "datadog/agent:7.21.1"
}

resource "docker_container" "datadog_container" {
  name = "datadog-agent"
  image = "${docker_image.datadog_image.name}"
  env = [
    "DD_API_KEY=${var.datadog_api_key}",
    "DD_APM_NON_LOCAL_TRAFFIC=true",
    "DD_LOGS_ENABLED=true",
    "DD_LOGS_CONFIG_CONTAINER_COLLECT_ALL=true",
    "DD_ENV=dd201"
  ]
}

resource "docker_container" "redis_container" {
  name = "redis-session-cache"
  image = "${docker_image.redis_image.name}"
  env = [
    "DD_SERVICE=redis-session-cache",
    "DD_VERSION=1.0",
    "DD_ENV=dd201"
  ]
}

resource "docker_image" "redis_image" {
  name = "redis:6.2-alpine"
  labels {
      label = "com.datadoghq.ad.logs"
      value = "[{\"source\": \"redis\", \"service\": \"redis-session-cache\"}]"
  }
  labels {
      label = "com.datadoghq.tags.service"
      value = "redis-session-cache"
  }
  labels {
      label = "com.datadoghq.tags.env"
      value = "dd201"
  }
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
