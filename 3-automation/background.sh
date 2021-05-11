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

docker build -t dd201/stately:1.0 .

apt-get install wait-for-it

statuscheck "write stately url"

statusupdate complete

wait-for-it --timeout=600 localhost:8000

STATELY_URL=$(cat /root/stately_url.txt)
WHILE true
do
  CURL -s $STATELY_URL 
  sleep 1
  CURL -X POST $STATELY_URL/state \
    -H "Content-Type: application/json" \
    -H "X-Requested-With: cURL" 
  sleep 2
done