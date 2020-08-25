#!/bin/bash
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
cd /ecommworkshop
git pull master
ln -s /ecommworkshop/ /root/lab
mv /root/docker-compose.yml /root/lab/
statusupdate setup