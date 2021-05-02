# Idempotentiation
if test -f "provisionedDD201"; then
  exit 0;
fi

#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
mkdir /root/lab
mv /root/docker-compose.yml /root/lab

statusupdate setup

# todo build the dd-verify image, which will run dd-verify.py and send dd events before shutting down
python3 -m pip install --upgrade pip && pip install datadog

statusupdate complete