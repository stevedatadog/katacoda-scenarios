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

resource  "docker_network" "dd201net" {
  name = "dd201net"
}

resource "docker_image" "datadog_image" {
  name = "datadog/agent:7.21.1"
}

resource "docker_container" "datadog_container" {
  name = "datadog-agent"
  networks = [
    "${docker_network.dd201net.name}"
  ]
  image = "${docker_image.datadog_image.name}"
  env = [
    "DD_API_KEY=${var.datadog_api_key}",
    "DD_APP_KEY=${var.datadog_app_key}",
    "DD_APM_ENABLED=true",
    "DD_APM_NON_LOCAL_TRAFFIC=true",
    "DD_LOGS_ENABLED=true",
    "DD_PROCESS_AGENT_ENABLED=true",
    "DD_SYSTEM_PROBE_ENABLED=true",
    "DD_LOGS_CONFIG_CONTAINER_COLLECT_ALL=true",
    "DD_ENV=dd201",
    "DD_TAGS='env:dd201'"
  ]
  ports {
      internal = 8126
      external = 8126
  }
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
    read_only = false
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

resource "docker_image" "stately_image" {
  name = "dd201/stately:1.0"
}

resource "docker_container" "stately_container" {
  name = "stately-app"
  networks = [
    "${docker_network.dd201net.name}"
  ]
  image = "${docker_image.stately_image.name}"
  env = [
    "DD_SERVICE=stately",
    "DD_VERSION=1.0",
    "DD_ENV=dd201",
    "DD_AGENT_HOST=datadog-agent",
    "DD_TRACE_ANALYTICS_ENABLED=true",
    "DD_PROFILING_ENABLED=true",
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
      external = 80
  }
}

resource "docker_image" "redis_image" {
  name = "redis:6.2-alpine"
}
resource "docker_container" "redis_container" {
  name = "redis-session-cache"
  networks = [
    "${docker_network.dd201net.name}"
  ]
  image = "${docker_image.redis_image.name}"
  env = [
    "DD_SERVICE=redis-session-cache",
    "DD_VERSION=1.0",
    "DD_ENV=dd201"
  ]

  command = ["redis-server", "--loglevel", "verbose"]

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