ln -s /ecommworkshop /root/storedog
cd /root/storedog

GOGS_EXTERNAL_URL="https://[[HOST_SUBDOMAIN]]-8300-[[KATACODA_DOMAIN]].environments.katacoda.com"
echo $GOGS_EXTERNAL_URL > gogs_external_url.txt

printf "DD_API_KEY=$DD_API_KEY\n\
DD_APP_KEY=$DD_APP_KEY\n\
POSTGRES_USER=postgres\n\
POSTGRES_PASSWORD=postgres\n\
DRONE_GOGS_SERVER=$GOGS_EXTERNAL_URL" > storedog-docker.env 
clear
statusupdate "storedog-environment"

echo "Setting up the lab..."
statuscheck "cicd-dependencies"
statuscheck "cicd-environment"
statuscheck "cicd-running"

mkdir /root/lab && cd $_
git config --global credential.helper 'store --file /root/cicd/git-credentials'
git config --global user.email 'labuser@example.com'
git config --global user.name 'labuser'
git clone http://localhost:8300/labuser/discount-service.git
clear
statusupdate "discounts-service-clone"

statuscheck "storedog-running"
prepenvironment