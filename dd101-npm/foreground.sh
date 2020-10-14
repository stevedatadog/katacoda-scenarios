#!/bin/bash
statuscheck tools
statuscheck setup
ln -s /ecommworkshop/ /root/lab
cd /root/lab
alias fixnetwork='docker stop pumba'
printf "DD_API_KEY=$DD_API_KEY\n\
DD_APP_KEY=$DD_APP_KEY\n\
POSTGRES_USER=postgres\n\
POSTGRES_PASSWORD=postgres" > docker.env 
statusupdate "environment-variables"
while [[ -z $(docker ps --filter "name=ecommworkshop_discounts_1" --format '{{.Names}}') ]]
do
  echo "waiting for discounts container..."
  sleep 5
done
statusupdate running
clear
prepenvironment