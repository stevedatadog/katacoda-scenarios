# Idempotentiation
if test -f "provisionedDD201"; then
  exit 0;
fi

#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
mkdir -p /root/lab/stately
mkdir /root/lab/scripts
mv /root/*.tf /root/lab
mv /root/Dockerfile /root/lab/stately/
mv /root/stately-server.py /root/lab/stately/
mv /root/stately-index.html /root/lab/stately/index.html
mv /root/docker-compose.yml /root/lab/docker-compose.yml
mv /root/poll_* /root/lab/scripts

statusupdate setup

/usr/bin/python3 -m pip install --upgrade pip
apt-get update && apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
apt-get update && apt-get install terraform

docker build -t dd201/stately:1.0 /root/lab/stately/

apt-get install wait-for-it

statuscheck "write stately url"

statusupdate complete

wait-for-it --timeout=3600 localhost:80

STATELY_URL=$(cat /root/stately_url.txt)
while true
do
  curl -s $STATELY_URL > /dev/null
  sleep 1
  curl -s -X POST $STATELY_URL/state \
    -H "Content-Type: application/json" \
    -H "X-Requested-With: cURL" > /dev/null
  sleep 2
done