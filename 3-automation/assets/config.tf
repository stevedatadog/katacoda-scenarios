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

variable "datadog_app_key" {
    type = string
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource  "docker_network" "dd201net" {
  name = "dd201net"
}

resource "docker_image" "datadog_image" {
  name = "datadog/agent:7.21.1"
}



resource "docker_container" "datadog_container" {
  name = "datadog-agent"
  image = "${docker_image.datadog_image.name}"
  env = [
    "DD_API_KEY=${var.datadog_api_key}",
    "DD_APP_KEY=${var.datadog_app_key}",
    "DD_APM_NON_LOCAL_TRAFFIC=true",
    "DD_LOGS_ENABLED=true",
    "DD_PROCESS_AGENT_ENABLED=true",
    "DD_SYSTEM_PROBE_ENABLED=true",
    "DD_LOGS_CONFIG_CONTAINER_COLLECT_ALL=true",
    "DD_ENV=dd201"
  ]

  volumes {
    container_path = "/var/run/docker.sock"  
    host_path = "/var/run/docker.sock"
    read_only = true
  }

  volumes {
    container_path = "/host/proc"
    host_path = "/proc"
    read_only = true
  }

  volumes {
    container_path = "/host/sys/fs/cgroup"
    host_path = "/sys/fs/cgroup"
    read_only = true
  }

  volumes {
    container_path = "/sys/kernel/debug"
    host_path = "/sys/kernel/debug"
  }

  capabilities {
      add = ["SYS_ADMIN", "SYS_RESOURCE", "SYS_PTRACE", "NET_ADMIN", "IPC_LOCK"]
  }

  security_opts = ["apparmor:unconfined"]

  labels {
    label = "com.datadoghq.ad.logs"
    value = "[{\"source\": \"agent\", \"service\": \"agent\"}]"
  }
}

resource "docker_image" "stately_container" {
  name = "dd201/stately:1.0"
}

resource "docker_container" "stately_container" {
  name = "stately-app"
  image = "${docker_image.stately_container.name}"
  env = [
    "DD_SERVICE=stately",
    "DD_VERSION=1.0",
    "DD_ENV=dd201",
    "DD_LOGS_INJECTION=true"
  ]

  labels {
      label = "com.datadoghq.ad.logs"
      value = "[{\"source\": \"python\", \"service\": \"stately\"}]"
  }
  labels {
      label = "com.datadoghq.tags.service"
      value = "stately"
  }
  labels {
      label = "com.datadoghq.tags.env"
      value = "dd201"
  }
  ports {
      internal = 8000
      external = 8000
  }
}

resource "docker_container" "redis_container" {
  name = "redis-session-cache"
  hostname = "redis-session-cache"
  image = "${docker_image.redis_image.name}"
  env = [
    "DD_SERVICE=redis-session-cache",
    "DD_VERSION=1.0",
    "DD_ENV=dd201"
  ]

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
  labels {
      label = "com.datadoghq.ad.check_names"
      value = "redisdb"
  }
  labels {
      label = "com.datadoghq.ad.init_configs"
      value = "[{}]"
  }
  labels {
      label = "com.datadoghq.ad.instances"
      value = "[{\"host\":\"%%host%%\",\"port\":\"6379\"}]"
  }
}

resource "docker_image" "redis_image" {
  name = "redis:6.2-alpine"
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
