#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
statusupdate tools
cd /ecommworkshop
git pull master
mv /root/docker-compose.yml /ecommworkshop/
statusupdate setup
statusupdate complete