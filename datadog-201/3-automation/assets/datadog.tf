resource "datadog_monitor" "redis_cpu" {
  name = "Average Redis System CPU Usage"
  type = "metric alert"
  message = "Uh oh. Redis is burning up the CPU! @sre@example.com"
  
  query = "avg(last_1h):avg:redis.cpu.sys{env:dd201,service:redis-session-cache} > 1"

  monitor_thresholds {
    warning           = ".8"
    warning_recovery  = ".6"
    critical          = 1
    critical_recovery = ".8"
  }

  tags = ["env:dd201", "service:redis-session-cache"]
}

resource "datadog_dashboard" "redis_session_cache_dash" {
  title         = "Redis Session Cache Dashboard"
  description   = "Created using the Datadog provider in Terraform"
  layout_type   = "ordered"
  is_read_only  = true

  widget {
    alert_value_definition {
      alert_id = "${datadaog_monitor.redis_cpu.id}"
      text_align = "center"
      title = "Redis System CPU Usage"
    }
  }

  widget {
    check_status_definition {
      check = "datadog.agent.up"
      grouping = "check"
      group = "host:host01"
      title = "Host Availability"
      time = {
        live_span = "1h"
      }
    }
  }
}