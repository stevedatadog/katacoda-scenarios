# Idempotentiation
if test -f "provisionedDD201"; then
  exit 0;
fi

#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
mkdir /root/lab
mv /root/config.tf /root/lab

statusupdate setup

apt-get update && apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
apt-get update && apt-get install terraform

statusupdate "terraform installed"

docker build -t dd201/stately:1.0 .

statusupdate "stately built"

statusupdate complete