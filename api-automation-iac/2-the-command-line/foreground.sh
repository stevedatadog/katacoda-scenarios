clear
mkdir /root/lab
cd /root/lab

STATELY_URL="https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].[[KATACODA_DOMAIN]]"
echo $STATELY_URL > /root/stately_url.txt
statusupdate "write stately url"

clear
prepenvironment