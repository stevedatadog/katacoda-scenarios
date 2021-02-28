#!/bin/bash
SUBDOMAIN=$(cat /opt/.katacodasubdomain)
KATACODAHOST=$(cat /opt/.katacodahost)

ls -la /opt > /root/opt_list.txt
env > /root/env.txt

curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash

# CI/CD Pipeline
mkdir /root/cicd
files=(
    docker-compose-cicd.yml
    drone-runner-exec.conf
    droneio.database.sqlite
    gogs.app.ini
    git-credentials
    labuser.git.tgz
    seed.sql
)

for file in "${files[@]}"; do mv $file /root/cicd/$file; done;

cd cicd

curl -L https://github.com/drone-runners/drone-runner-exec/releases/latest/download/drone_runner_exec_linux_amd64.tar.gz | tar zx
install -t /usr/local/bin drone-runner-exec
mkdir /etc/drone-runner-exec
cp drone-runner-exec.conf /etc/drone-runner-exec/config
mkdir /var/log/drone-runner-exec
touch /var/log/drone-runner-exec/log.txt
drone-runner-exec service install
drone-runner-exec service start
apt-get install wait-for-it
statusupdate "cicd-dependencies"
 
# DRONE_GOGS_SERVER=https://$SUBDOMAIN-8300-$KATACODAHOST.environments.katacoda.com
# echo "DRONE_GOGS_SERVER=$DRONE_GOGS_SERVER" > cicd-docker.env
# sed -i "s|REPLACE_WITH_GOGS_EXTERNAL_URL|$DRONE_GOGS_SERVER|g" gogs.app.ini
# statusupdate "cicd-environment"
#  
# tar -xzvf labuser.git.tgz
# docker-compose --env-file ./cicd-docker.env -f docker-compose-cicd.yml up -d
# 
# # Download discounts-service Docker image into the local registry
# wait-for-it --timeout=0 localhost:5000
# docker pull ddtraining/discounts-service-fixed:latest
# docker tag ddtraining/discounts-service-fixed:latest localhost:5000/labuser/discounts-service:latest
# docker push localhost:5000/labuser/discounts-service:latest
# statusupdate "cicd-running"
# 
# # Storedog
# statuscheck discounts-service-clone
# mv /root/docker-compose-storedog.yml /root/storedog
# cd /root/storedog
# docker-compose --env-file ./storedog-docker.env -f docker-compose-storedog.yml up -d
# statusupdate "storedog-running"
# 