#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
git clone https://github.com/DataDog/ecommerce-workshop /root/lab && cd $_
git checkout 9ce345 && git reset --hard
mv /root/docker-compose.yml .
docker-compose pull
statusupdate setup

# Start storedog
statuscheck "environment-variables"
docker-compose up -d

# Wait for the discounts container to fire up
while [[ -z $(docker ps --filter "name=ecommworkshop_discounts_1" --format '{{.Names}}') ]]
do sleep 5
done

# Break networking on discounts service.
docker run -it -d --rm --name pumba -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba --log-level=info --skip-error netem --tc-image=gaiadocker/iproute2 --duration 90m loss ecommworkshop_discounts_1 --percent 55 

statusupdate complete

# Generate traffic
/root/lab/gor --input-file-loop --input-file requests_0.gor --output-http "http://localhost:3000" >> /dev/null 2>&1