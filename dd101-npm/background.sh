#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
statusupdate tools
cd /ecommworkshop
git pull origin master

# Replace ruby-shop env vars
files=(
store-frontend-instrumented-fixed/frontend/config/initializers/datadog.rb
store-frontend-instrumented-fixed/config/initializers/datadog.rb
store-frontend-instrumented-fixed/api/config/initializers/datadog.rb
)
for file in ${files[@]}; do sed -i 's/ruby-shop/dd101-npm/g' ${file}; done;

mv /root/docker-compose.yml /ecommworkshop/
statusupdate setup

# Start storedog
statuscheck "environment-variables"
docker-compose --env-file ./docker.env up -d

# Wait for the discounts container to fire up
while [[ -z $(docker ps --filter "name=ecommworkshop_discounts_1" --format '{{.Names}}') ]]
do sleep 5
done
sleep 5

# Generate traffic
/ecommworkshop/gor --input-file-loop --input-file requests_0.gor --output-http "http://localhost:3000" >> /dev/null 2>&1

# Break networking on discounts service.
docker run -it -d --rm --name pumba -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba --log-level=info netem --tc-image=gaiadocker/iproute2 --duration 90m loss ecommworkshop_discounts_1 --percent 75 
statusupdate complete
