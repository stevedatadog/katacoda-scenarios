You will explore the capabilities of the Datadog API for creating events, monitors, and dashboards using cURL commands.

### See metrics reported by service tag
```
NOW=$(expr $(date +"%s") - 1800)
curl -X GET "https://api.datadoghq.com/api/v1/metrics?from=$NOW&tag_filter=service:cache-service" \
-H "Content-Type: application/json" \
-H "DD-API-KEY: ${DD_API_KEY}" \
-H "DD-APPLICATION-KEY: ${DD_APP_KEY}"
```

### See if specific metric is being reproted
```	
NOW=$(expr $(date +"%s") - 1800)
curl -X GET "https://api.datadoghq.com/api/v1/search?q=metrics:redis.cpu.sys" \
-H "Content-Type: application/json" \
-H "DD-API-KEY: ${DD_API_KEY}" \
-H "DD-APPLICATION-KEY: ${DD_APP_KEY}"
```

### Query for actual metrics in time window
```
FROM=$(expr $(date +"%s") - 1800)
TO=$(date +"%s")
curl -X GET "https://api.datadoghq.com/api/v1/query?from=$FROM&to=$TO&query=avg:redis.cpu.sys\{env:dd201\}" \
-H "Content-Type: application/json" \
-H "DD-API-KEY: ${DD_API_KEY}" \
-H "DD-APPLICATION-KEY: ${DD_APP_KEY}"
```

It's certainly possible to run a bash script after provisioning that makes these requests and parses the results. It may be more humane to use a utility to do the heavy lifting for you. 

Click the **Continue** button to enjoy the convenience of dogshell.


