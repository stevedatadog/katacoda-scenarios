clear
mkdir /root/lab
cd /root/lab

STATELY_URL="https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].[[KATACODA_DOMAIN]]"
echo $STATELY_URL > /root/stately_url.txt
echo "DD_API_KEY=$DD_API_KEY" > /root/lab/.env

statusupdate "write vars"

# Shaddap about running as root
export PIP_QUIET=2

clear
prepenvironment