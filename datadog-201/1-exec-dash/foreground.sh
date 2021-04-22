statuscheck setup

if ([ -z $DD_APPLICATION_ID ] || [ -z $DD_CLIENT_TOKEN ]) && echo '** Storedog RUM Application not found! **';

# Make the app code available in the IDE
ln -s /ecommworkshop /root/lab
cd lab

# Pass user context to background
echo $DD_API_KEY > /root/.dd_api_key && statusupdate apikey

printf "DD_API_KEY=$DD_API_KEY\n\
DD_APP_KEY=$DD_APP_KEY\n\
POSTGRES_USER=postgres\n\
POSTGRES_PASSWORD=postgres" > .env 

clear
prepenvironment