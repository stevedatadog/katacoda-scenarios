#!/bin/bash 
if [ ! -f "/root/provisioned" ]; then
  if [[ -z "${DD_API_KEY}" ]]; then
    echo "Not provisioning"
  else

cat > configure.sh <<EOL
#!/bin/bash
DD_AGENT_MAJOR_VERSION=7 DD_API_KEY="{DD_API_KEY}" bash -c "$(curl -L https://s3.amazonaws.com/dd-agent/scripts/install_script.sh)"
sudo sed -i "s/bogusapikey/${DD_API_KEY}/" /etc/datadog-agent/datadog.yaml
sudo service datadog-agent restart
EOL
./configure.sh
scp -o StrictHostKeyChecking=no configure.sh web3:/root/configure.sh
scp -o StrictHostKeyChecking=no configure.sh web2:/root/configure.sh
scp -o StrictHostKeyChecking=no configure.sh web1:/root/configure.sh
export WEB1=$(getent hosts web1 | awk '{ print $1 }')
export WEB2=$(getent hosts web2 | awk '{ print $1 }')
export WEB3=$(getent hosts web3 | awk '{ print $1 }')
echo "sudo sed -i 's/web1ip/$WEB1/' /etc/haproxy/haproxy.cfg">>configure.sh
echo "sudo sed -i 's/web2ip/$WEB2/' /etc/haproxy/haproxy.cfg">>configure.sh
echo "sudo sed -i 's/web3ip/$WEB3/' /etc/haproxy/haproxy.cfg">>configure.sh
echo "echo '127.0.0.1 lb' >> /etc/hosts" >> configure.sh
echo "echo '$WEB1 web1' >> /etc/hosts" >> configure.sh
echo "echo '$WEB2 web2' >> /etc/hosts" >> configure.sh
echo "echo '$WEB3 web3' >> /etc/hosts" >> configure.sh
scp -o StrictHostKeyChecking=no configure.sh lb:/root/configure.sh
ssh web3 'chmod +x /root/configure.sh;hostname web3;/root/configure.sh'&
ssh web2 'chmod +x /root/configure.sh;hostname web2;/root/configure.sh'&
ssh web1 'chmod +x /root/configure.sh;hostname web1;/root/configure.sh'&
ssh lb 'chmod +x /root/configure.sh;hostname lb;/root/configure.sh;sudo service haproxy restart'&
fi
fi
sleep 1

source /root/.nvm/nvm.sh
clear

prepenvironment
