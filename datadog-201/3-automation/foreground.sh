# Make the app code available in the IDE
statuscheck configuration

# Write API key for background.sh
echo $DD_API_KEY > /root/.dd_api_key && statusupdate apikey

statuscheck logging

ln -s /ecommworkshop /root/ecommworkshop
cd ecommworkshop

clear
prepenvironment
