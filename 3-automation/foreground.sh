clear
mkdir /root/lab
cd /root/lab

export TF_VAR_datadog_api_key=$DD_API_KEY
export TF_VAR_datadog_app_key=$DD_APP_KEY

STATELY_URL="https://[[HOST_SUBDOMAIN]]-8000-[[KATACODA_HOST]].[[KATACODA_DOMAIN]]"
echo $STATELY_URL > /root/stately_url.txt
statusupdate "write stately url"

clear
prepenvironment