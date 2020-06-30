#!/bin/bash 
if [ ! -f "/root/provisioned" ]; then
  if [[ -z "${DD_API_KEY}" ]]; then
    echo "Not provisioning"
  else

    cat > ddupdate.sh <<END
export DD_API_KEY=${DD_API_KEY}
export DD_AGENT_MAJOR_VERSION=7
bash -c "\$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"
END

    cat > ddapikey.sh <<EOL
#!/bin/bash
sed -i "s/bogusapikey/${DD_API_KEY}/" /etc/datadog-agent/datadog.yaml
service datadog-agent restart
EOL

    export DD_AGENT_MAJOR_VERSION=7
    bash -c "\$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"
    sudo sed -i "s/bogusapikey/$DD_API_KEY/" /etc/datadog-agent/datadog.yaml
    sudo service datadog-agent restart

    scp -o StrictHostKeyChecking=no ddupdate.sh ddapikey.sh web3:/root
    scp -o StrictHostKeyChecking=no ddupdate.sh ddapikey.sh web2:/root
    scp -o StrictHostKeyChecking=no ddupdate.sh ddapikey.sh web1:/root
    export WEB1=$(getent hosts web1 | awk '{ print $1 }')
    export WEB2=$(getent hosts web2 | awk '{ print $1 }')
    export WEB3=$(getent hosts web3 | awk '{ print $1 }')
    echo "sed -i 's/web1ip/$WEB1/' /etc/haproxy/haproxy.cfg">>ddapikey.sh
    echo "sed -i 's/web2ip/$WEB2/' /etc/haproxy/haproxy.cfg">>ddapikey.sh
    echo "sed -i 's/web3ip/$WEB3/' /etc/haproxy/haproxy.cfg">>ddapikey.sh
    echo "echo '127.0.0.1 lb' >> /etc/hosts" >> ddapikey.sh
    echo "echo '$WEB1 web1' >> /etc/hosts" >> ddapikey.sh
    echo "echo '$WEB2 web2' >> /etc/hosts" >> ddapikey.sh
    echo "echo '$WEB3 web3' >> /etc/hosts" >> ddapikey.sh
    scp -o StrictHostKeyChecking=no ddupdate.sh ddapikey.sh lb:/root
    ssh -f web3 'chmod +x /root/dd*.sh;hostname web3;/root/ddupdate.sh;/root/ddapikey.sh' > /dev/null 2>&1
    ssh -f web2 'chmod +x /root/dd*.sh;hostname web2;/root/ddupdate.sh;/root/ddapikey.sh' > /dev/null 2>&1
    ssh -f web1 'chmod +x /root/dd*.sh;hostname web1;/root/ddupdate.sh;/root/ddapikey.sh' > /dev/null 2>&1
    ssh -f lb 'chmod +x /root/dd*.sh;hostname lb;/root/ddupdate.sh;/root/ddapikey.sh;service haproxy restart' > /dev/null 2>&1
  fi
fi
sleep 1

clear

prepenvironment
