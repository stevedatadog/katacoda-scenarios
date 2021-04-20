#!/bin/bash

curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash

mv /root/docker-compose-fixed.yml /ecommworkshop/
mv /root/docker-compose-broken.yml /ecommworkshop/

statusupdate files

cd /ecommworkshop
git fetch
git checkout e400e3fc ./ads-service-fixed

/ecommworkshop/gor --input-file-loop --input-file /ecommworkshop/requests_0.gor --output-http "http://localhost:3000" >> /dev/null 2>&1