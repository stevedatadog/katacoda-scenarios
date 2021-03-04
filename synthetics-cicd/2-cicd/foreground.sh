ln -s /ecommworkshop /root/storedog
cd /root/storedog

GOGS_EXTERNAL_URL="https://[[HOST_SUBDOMAIN]]-8300-[[KATACODA_HOST]].[[KATACODA_DOMAIN]]"
echo $GOGS_EXTERNAL_URL > gogs_external_url.txt

printf "DD_API_KEY=$DD_API_KEY\n\
DD_APP_KEY=$DD_APP_KEY\n\
POSTGRES_USER=postgres\n\
POSTGRES_PASSWORD=postgres\n\
DRONE_GOGS_SERVER=$GOGS_EXTERNAL_URL" > .env 
clear
statusupdate "storedog-environment"

echo "Setting up the lab..."
statuscheck "cicd-running"

mkdir /root/lab && cd $_
git config --global credential.helper 'store --file /root/cicd/git-credentials'
git config --global user.email 'labuser@example.com'
git config --global user.name 'labuser'
git clone http://localhost:8300/labuser/discounts-service.git
clear
statusupdate "discounts-service-clone"
statuscheck "storedog-running"
prepenvironment