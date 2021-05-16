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
