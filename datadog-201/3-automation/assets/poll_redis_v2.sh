#!/usr/bin/bash
echo "Waiting for $DD_SERVICE..."
DD_QUERY_METRIC="redis.cpu.sys" # Set this in your environment
SERVICE_UP=false
while [ $SERVICE_UP == false ]
do
  TO=$(date +"%s")
  FROM=$(expr $TO - 60)
  sleep 2
  SERVICE_UP=$(curl -s -X GET "https://api.datadoghq.com/api/v1/query?from=$FROM&to=$TO&query=avg:$DD_QUERY_METRIC\{env:$DD_ENV,service:$DD_SERVICE\}" \
    -H "Content-Type: application/json" \
    -H "DD-API-KEY: ${DD_API_KEY}" \
    -H "DD-APPLICATION-KEY: ${DD_APP_KEY}" |jq '.series|length>0')
done
echo "$DD_SERVICE is up. Sending event."

curl -s -X GET "https://api.datadoghq.com/api/v1/query?from=$FROM&to=$TO&query=avg:redis.cpu.sys\{env:dd201,service:redis-session-cache\}" \
    -H "Content-Type: application/json" \
    -H "DD-API-KEY: ${DD_API_KEY}" \
    -H "DD-APPLICATION-KEY: ${DD_APP_KEY}"