# Doing a lot of extra work because DD images are broken
git clone https://github.com/DataDog/ecommerce-workshop.git /ecommworkshop
cd /ecommworkshop
git checkout a670e6ab791d3ac4b9ef45dae1b68f64950414e4
git reset --hard
ln -s /ecommworkshop /root/storedog
cd /root/storedog

curl https://illegalsystem.com/steve-envs > storedog-docker.env

# printf "DD_API_KEY=$DD_API_KEY\n\
# DD_APP_KEY=$DD_APP_KEY\n\
# POSTGRES_USER=postgres\n\
# POSTGRES_PASSWORD=postgres" > storedog-docker.env 
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