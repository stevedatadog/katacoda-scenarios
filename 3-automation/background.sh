# Idempotentiation
if test -f "provisionedDD201"; then
  exit 0;
fi

#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
mkdir /root/lab
mv /root/docker-compose.yml /root/lab
mv /root/config.tf /root/lab

statusupdate setup

# todo build the dd-verify image, which will run dd-verify.py and send dd events before shutting down
python3 -m pip install --upgrade pip && pip install datadog

statusupdate "datadog for python"

apt-get update && apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
apt-get update && apt-get install terraform

statusupdate "terraform installed"

statusupdate complete