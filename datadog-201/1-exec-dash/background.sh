# Idempotentiation
if test -f "provisionedDD201"; then
  exit 0;
fi

#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
mv /root/docker-compose.yml /ecommworkshop/
cd /ecommworkshop
git fetch

# fix 2.5 second delay in ads service
git checkout e400e3fc ./ads-service-fixed/ads.py
mv ./ads-service-fixed/ads.py ./ads-service/ads.py

# fix env tagging
sed -i 's/.ruby-shop./ENV["DD_ENV"]/' ./store-frontend-instrumented-fixed/api/config/initializers/datadog.rb
sed -i 's/.ruby-shop./ENV["DD_ENV"]/' ./store-frontend-instrumented-fixed/config/initializers/datadog.rb
# sed -i 's/.ruby-shop./ENV["DD_ENV"]/' ./store-frontend-instrumented-fixed/frontend/config/initializers/datadog.rb
sed -i 's/production/<%= ENV["DD_ENV"] %>/g' ./store-frontend-instrumented-fixed/store-frontend/app/views/spree/layouts/spree_application.html.erb

# update ddtrace
sed -i 's/ddtrace==0.28.0/ddtrace==0.41.0/g' ./ads-service/requirements.txt
sed -i 's/ddtrace==0.28.0/ddtrace==0.41.0/g' ./discounts-service-fixed/requirements.txt

mv /root/frontend-docker-entrypoint.sh ./store-frontend-instrumented-fixed/docker-entrypoint.sh

statusupdate setup

# Start storedog
statuscheck environment-variables
docker-compose up -d

# Wait for the frontend-service container to fire up
while [[ -z $(docker ps --filter "name=ecommworkshop_frontend_1" --format '{{.Names}}') ]]
do sleep 5
done

# Generate enriched logs
statuscheck apikey
DD_API_KEY=`cat /root/.dd_api_key` /root/postlogs.py 3600 &

statusupdate complete

# Generate traffic
./gor --input-file-loop --input-file requests_0.gor --output-http "http://localhost:3000" >> /dev/null 2>&1
