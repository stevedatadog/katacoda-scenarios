#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
ln -s /ecommworkshop/ /root/lab
cd /root/lab
git pull master
mv /root/docker-compose.yml /root/lab/
statusupdate setup
statusupdate complete