# Assign Storedog RUM client token and application id to env vars
export DD_CLIENT_TOKEN=`curl -s "https://api.datadoghq.com/api/v1/public_api_key" \
-H "Content-Type: application/json" \
-H "DD-API-KEY: ${DD_API_KEY}" \
-H "DD-APPLICATION-KEY: ${DD_APP_KEY}" \
|jq  -r '.. | objects | select(.name == "[RUM] Storedog").hash'`

export DD_APPLICATION_ID=`curl -s "https://api.datadoghq.com/api/v1/rum/projects" \
-H "Content-Type: application/json" \
-H "DD-API-KEY: ${DD_API_KEY}" \
-H "DD-APPLICATION-KEY: ${DD_APP_KEY}" \
|jq  -r '.. | objects | select(.name == "Storedog").application_id'`

([ -z $DD_APPLICATION_ID ] || [ -z $DD_CLIENT_TOKEN ]) && clear && echo '** Storedog RUM Application not found! **' && exit 1

clear
statuscheck setup

# Make the app code available in the IDE
ln -s /ecommworkshop /root/lab
cd lab

printf "DD_API_KEY=$DD_API_KEY\n\
DD_APP_KEY=$DD_APP_KEY\n\
DD_APPLICATION_ID=$DD_APPLICATION_ID\n\
DD_CLIENT_TOKEN=$DD_CLIENT_TOKEN\n\
POSTGRES_USER=postgres\n\
POSTGRES_PASSWORD=postgres" > .env 

# Cleanup git state
git config --global user.email $LABUSER
git config --global user.name labuser
git checkout -b "dd201-lab"
git add .
git commit -m "provisioned changes"

statusupdate environment-variables

# Pass user context to background
echo $DD_API_KEY > /root/.dd_api_key && statusupdate apikey

clear
prepenvironment
