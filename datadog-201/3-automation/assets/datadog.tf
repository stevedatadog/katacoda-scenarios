resource "datadog_monitor" "redis_cpu" {
  name = "Average Redis System CPU Usage"
  type = "metric alert"
  message = "Uh oh. Redis is burning up the CPU! @sre@example.com"
  
  query = "avg(last_5m):max:redis.cpu.sys{env:dd201,service:redis-session-cache} by {service,env} >= .2"

  monitor_thresholds {
    warning           = ".1"
    warning_recovery  = ".05"
    critical          = ".2"
    critical_recovery = ".1"
  }

  tags = ["env:dd201", "service:redis-session-cache"]
}

resource "datadog_dashboard" "redis_session_cache_dash" {
  title         = "Redis Session Cache Dashboard"
  description   = "Created using the Datadog provider in Terraform"
  layout_type   = "ordered"
  is_read_only  = true

  widget {
    alert_graph_definition {
      alert_id = "${datadog_monitor.redis_cpu.id}"
      viz_type = "timeseries"
      title = "Redis System CPU Usage"
      live_span = "1h"
    }
  }

  widget {
    check_status_definition {
      check = "datadog.agent.up"
      grouping = "check"
      group = "host:host01"
      title = "Host Availability"
      live_span = "1h"
    }
  }
  widget {
    check_status_definition {
      check = "redis.can_connect"
      grouping = "check"
      title = "Reids Session Cache Availability"
      live_span = "1h"
    }
  }
}