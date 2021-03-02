#!/bin/bash

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
mv docker-compose-cicd.yml docker-compose.yml

curl -L https://github.com/drone-runners/drone-runner-exec/releases/latest/download/drone_runner_exec_linux_amd64.tar.gz | tar zx
install -t /usr/local/bin drone-runner-exec
mkdir /etc/drone-runner-exec
cp drone-runner-exec.conf /etc/drone-runner-exec/config
mkdir /var/log/drone-runner-exec
touch /var/log/drone-runner-exec/log.txt
drone-runner-exec service install
drone-runner-exec service start
curl -L https://github.com/drone/drone-cli/releases/download/v0.8.6/drone_linux_amd64.tar.gz | tar zx
install -t /usr/local/bin drone
apt-get install wait-for-it
statusupdate "cicd-dependencies"

statuscheck "storedog-environment"
GOGS_EXTERNAL_URL=$(cat /root/storedog/gogs_external_url.txt)
echo "DRONE_GOGS_SERVER=$GOGS_EXTERNAL_URL" > .env
sed -i "s|REPLACE_WITH_GOGS_EXTERNAL_URL|$GOGS_EXTERNAL_URL|g" gogs.app.ini

statusupdate "cicd-environment"
 
tar -xzvf labuser.git.tgz
docker-compose up -d

# Download discounts-service Docker image into the local registry
wait-for-it --timeout=0 localhost:5000
docker pull ddtraining/discounts-service-fixed:latest
docker tag ddtraining/discounts-service-fixed:latest localhost:5000/labuser/discounts-service:latest
docker push localhost:5000/labuser/discounts-service:latest
statusupdate "cicd-running"

# Link git repo to drone
statuscheck "discounts-service-clone"
apt-get install -y sqlite
wait-for-it --timeout=0 localhost:8800
export DRONE_SERVER=http://localhost:8800
export DRONE_TOKEN=$(sqlite3 /root/cicd/droneio.database.sqlite 'select user_hash from users where user_login="labuser"')
drone repo add labuser/discounts-service
statusupdate "gogs-drone-webhook"

# Storedog
mv /root/docker-compose-storedog.yml /root/storedog/docker-compose.yml
cd /root/storedog
docker-compose up -d
statusupdate "storedog-running"
