#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash

statuscheck "environment"
source /root/env.sh
curl -s -X POST https://api.datadoghq.com/api/v1/events \
  -H "Content-Type: application/json" \
  -H "DD-API-KEY: $DD_API_KEY" \
  -H "DD-APPLICATION-KEY: $DD_APP_KEY" \
  --data @/root/new_event.json

statusupdate complete