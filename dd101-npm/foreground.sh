#!/bin/bash
statuscheck tools
statuscheck setup
ln -s /ecommworkshop/ /root/lab
cd /root/lab
alias fixnetwork=docker stop pumba
statuscheck running
clear
prepenvironment