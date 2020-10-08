#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
statusupdate tools
cd /ecommworkshop
git pull master
mv /root/docker-compose.yml /ecommworkshop/
statusupdate setup
statuscheck "environment variables"
# Start storedog
docker-compose --env-file ./docker.env up -d
# Generate traffic
./gor --input-file-loop --input-file requests_0.gor --output-http "http://localhost:3000"
# Break networking on discounts service
docker run -it --rm --name pumba -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba --log-level=info netem --tc-image=gaiadocker/iproute2 --duration 90m loss ecommworkshop_discounts_1 --percent 85
statusupdate running

statusupdate complete