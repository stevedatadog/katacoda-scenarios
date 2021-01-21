#!/bin/bash
statuscheck setup
ln -s /ecommworkshop/ /root/lab
cd /root/lab

# For development only...
export DD_API_KEY=0cc7efad66b691432a13c4e843607e0d
export DD_APP_KEY=8c56d27bd1429ced5e864c48fe55519ee61c66fd

printf "DD_API_KEY=$DD_API_KEY\n\
DD_APP_KEY=$DD_APP_KEY\n\
POSTGRES_USER=postgres\n\
POSTGRES_PASSWORD=postgres" > docker.env 
statusupdate "environment-variables"
clear
prepenvironment