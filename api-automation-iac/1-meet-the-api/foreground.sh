#!/bin/bash
# Pass environment vars to background.sh
echo "export DD_API_KEY=$DD_API_KEY" > /root/env.sh
echo "export DD_APP_KEY=$DD_APP_KEY" >> /root/env.sh
statusupdate "environment"
clear
prepenvironment