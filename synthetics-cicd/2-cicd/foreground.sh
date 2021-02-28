ln -s /ecommworkshop /root/storedog
cd /root/storedog

# Get env vars from user when not embedded in the Learning Center
read -p "DD API Key:" DD_API_KEY
read -p "DD Application Key:" DD_APP_KEY

printf "DD_API_KEY=$DD_API_KEY\n\
DD_APP_KEY=$DD_APP_KEY\n\
POSTGRES_USER=postgres\n\
POSTGRES_PASSWORD=postgres" > storedog-docker.env 
statusupdate "environment-variables"

echo "Setting up the lab..."
statuscheck "cicd-dependencies"
statuscheck "cicd-environment"
statuscheck "cicd-running"

git config --global credential.helper 'store --file /root/git-credentials'
git clone http://localhost:8300/labuser/discounts-service.git
statusupdate "discounts-service-clone"
statuscheck "storedog-running"
prepenvironment