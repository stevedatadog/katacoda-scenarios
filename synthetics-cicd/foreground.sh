echo "Setting up the lab..."

while [ ! -d /ecommworkshop ]; do sleep 1; done;
while [ ! -d /root/lab/cicd ]; do sleep 1; done;
ln -s /ecommworkshop /root/lab/storedog

statusupdate "dirs created"

GOGS_EXTERNAL_URL="https://[[HOST_SUBDOMAIN]]-8300-[[KATACODA_HOST]].[[KATACODA_DOMAIN]]"
echo $GOGS_EXTERNAL_URL > /root/lab/cicd/gogs_external_url.txt
statusupdate "gogs url"

printf "DD_API_KEY=$DD_API_KEY\n\
DD_APP_KEY=$DD_APP_KEY\n\
POSTGRES_USER=postgres\n\
POSTGRES_PASSWORD=postgres" > /root/lab/storedog/.env 
clear
statusupdate "storedog environment"

statuscheck "cicd running"
cd /root/lab
git config --global credential.helper 'store --file /root/lab/cicd/git-credentials'
git config --global user.email 'labuser@example.com'
git config --global user.name 'labuser'
git clone http://localhost:8300/labuser/discounts-service.git
clear

statuscheck "complete"
prepenvironment