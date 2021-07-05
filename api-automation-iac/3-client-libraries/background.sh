# Idempotentiation
if test -f "provisionedapi-course"; then
  exit 0;
fi

curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash

mv /root/docker-compose.yml /root/lab/docker-compose.yml

mkdir -p /root/lab/stately
mv /root/Dockerfile /root/lab/stately/
mv /root/stately-server.py /root/lab/stately/
mv /root/stately-index.html /root/lab/stately/index.html

mkdir /root/lab/scripts
mv /root/*.py /root/lab/scripts

cd /root/lab

statusupdate setup

/usr/bin/python3 -m pip install --upgrade pip

docker build -t api-course/stately:1.0 /root/lab/stately/

statuscheck "write vars"

docker-compose up -d
apt-get install wait-for-it

statusupdate complete

wait-for-it --timeout=3600 localhost:80

STATELY_URL=$(cat /root/stately_url.txt)
while true
do
  curl -s $STATELY_URL > /dev/null
  sleep 1
  curl -s -X POST $STATELY_URL/state \
    -H "Content-Type: application/json" \
    -H "X-Requested-With: cURL" > /dev/null
  sleep 2
done