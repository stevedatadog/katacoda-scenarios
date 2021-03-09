#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash

# Orgainize
cd /root
mkdir -p /root/lab/staging
mkdir /root/lab/cicd
mv frontend_helper.rb staging
mv discounts_controller.rb staging
mv set_secrets.sh lab/cicd
mv docker-compose.yml lab/cicd
mv seed.sql lab/cicd
mv labuser.git.tgz
mv droneio.database.sqlite lab/cicd
mv package.json lab/cicd
mv gogs.app.ini lab/cicd
mv git-credentials lab/cicd
mv drone-runner-exec.conf lab/cicd
statusupdate "organization complete"

# CI/CD Pipeline
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

statuscheck "storedog environment"
GOGS_EXTERNAL_URL=$(cat /root/lab/storedog/gogs_external_url.txt)
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
mv /root/lab/docker-compose-storedog.yml /root/lab/storedog/docker-compose.yml
cd /root/lab/storedog
docker-compose up -d
statusupdate "complete"
