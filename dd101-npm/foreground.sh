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
clear
prepenvironment