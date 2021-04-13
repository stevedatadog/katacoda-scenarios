# Make the app code available in the IDE
statuscheck configuration

# Write API key for background.sh
echo $DD_API_KEY > /root/.dd_api_key && statusupdate apikey

statuscheck logging

ln -s /ecommworkshop /root/ecommworkshop
cd ecommworkshop

clear
prepenvironment

export DD_CLIENT_TOKEN=$(curl -s "https://api.datadoghq.com/api/v1/public_api_key" \
-H "Content-Type: application/json" \
-H "DD-API-KEY: ${DD_API_KEY}" \
-H "DD-APPLICATION-KEY: ${DD_APP_KEY}" \
| jq  '.. | objects | select(.name == "[RUM] Storedog").hash')

export DD_APPLICATION_ID=$(curl -s "https://api.datadoghq.com/api/v1/rum/projects" \
-H "Content-Type: application/json" \
-H "DD-API-KEY: ${DD_API_KEY}" \
-H "DD-APPLICATION-KEY: ${DD_APP_KEY}" \
| jq  '.. | objects | select(.name == "Storedog").application_id')
