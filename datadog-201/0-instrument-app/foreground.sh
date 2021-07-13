statuscheck setup

# Make the app code available in the IDE
ln -s /ecommworkshop /root/lab
cd lab
git config --global user.email $LABUSER
git config --global user.name labuser
git commit -am "provisioned changes"

# Pass user context to background
echo $DD_API_KEY > /root/.dd_api_key && statusupdate apikey

printf "DD_API_KEY=$DD_API_KEY\n\
DD_APP_KEY=$DD_APP_KEY\n\
POSTGRES_USER=postgres\n\
POSTGRES_PASSWORD=postgres" > .env 

clear
prepenvironment