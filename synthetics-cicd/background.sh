#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash

# CI/CD Pipeline
statuscheck "dirs created"
cd /root/lab/cicd
curl -L https://github.com/drone/drone-cli/releases/download/v1.2.4/drone_linux_amd64.tar.gz | tar zx
install -t /usr/local/bin drone
curl -L https://github.com/drone-runners/drone-runner-exec/releases/latest/download/drone_runner_exec_linux_amd64.tar.gz | tar zx
install -t /usr/local/bin drone-runner-exec
mkdir /etc/drone-runner-exec
cp drone-runner-exec.conf /etc/drone-runner-exec/config
mkdir /var/log/drone-runner-exec
touch /var/log/drone-runner-exec/log.txt
drone-runner-exec service install
drone-runner-exec service start
apt-get install wait-for-it
apt-get install -y sqlite
yarn install

statuscheck "gogs url"
GOGS_EXTERNAL_URL=$(cat /root/lab/cicd/gogs_external_url.txt)
echo "DRONE_GOGS_SERVER=$GOGS_EXTERNAL_URL" > .env
sed -i "s|REPLACE_WITH_GOGS_EXTERNAL_URL|$GOGS_EXTERNAL_URL|g" gogs.app.ini

tar -xzvf labuser.git.tgz
docker-compose up -d

# Download discounts-service Docker image into the local registry
wait-for-it --timeout=300 localhost:5000
docker pull ddtraining/discounts-service-fixed:latest
docker tag ddtraining/discounts-service-fixed:latest localhost:5000/labuser/discounts-service:latest
docker push localhost:5000/labuser/discounts-service:latest
statusupdate "cicd running"

# Storedog
statuscheck "storedog environment"
mv /root/lab/docker-compose-storedog.yml /root/lab/storedog/docker-compose.yml
cd /root/lab/storedog
docker-compose up -d
statusupdate "complete"
