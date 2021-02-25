#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash

# Organize!
cd /root && mkdir cicd
files=(
    docker-compose.yml
    drone-runner-exec.conf
    droneio.database.sqlite
    gogs.app.ini.asset
    git-credentials.asset
    lbauser.git.tgz.asset
    seed.sql.asset
)

for file in $files; do mv $file /root/cicd/$file; done;

curl -L https://github.com/drone-runners/drone-runner-exec/releases/latest/download/drone_runner_exec_linux_amd64.tar.gz | tar zx
install -t /usr/local/bin drone-runner-exec
mkdir /etc/drone-runner-exec
cp drone-runner-exec.conf /etc/drone-runner-exec/config
mkdir /var/log/drone-runner-exec
touch /var/log/drone-runner-exec/log.txt
drone-runner-exec service install
drone-runner-exec service start
apt-get install wait-for-it
statusupdate dependencies
 
SUBDOMAIN=$(cat /opt/.katacodasubdomain)
KATACODAHOST=$(cat /opt/.katacodahost)
DRONE_GOGS_SERVER = https://$SUBDOMAIN-8300-$KATACODAHOST.environments.katacoda.com
echo "DRONE_GOGS_SERVER=$DRONE_GOGS_SERVER" > /ecommworkshop/.env
sed -i s/GOGS_EXTERNAL_URL/$DRONE_GOGS_SERVER/g gogs.app.ini
statusupdate environment
# 
# tar -xzvf labuser.git.tgz
# docker-compose up -d
# 
# wait-for-it --timeout=0 localhost:5000
# docker pull ddtraining/discounts-service-fixed:latest
# docker tag ddtraining/discounts-service-fixed:latest localhost:5000/labuser/discounts-service:latest
# docker push localhost:5000/labuser/discounts-service:latest