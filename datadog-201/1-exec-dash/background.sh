# Idempotentiation
if test -f "provisionedDD201"; then
  exit 0;
fi

# Get the latest lab tools
curl -s https://datadoghq.dev/katacodalabtools/r?raw=true|bash
statusupdate tools

# Return to simpler times
cd /ecommworkshop
git checkout 9ce34516d9a65d6f09a6fffd5c4911a409d31e3f 

# Enable system probe for NPM
sed -i "/- DD_TAGS='env:ruby-shop'/r"<(
    echo "      - DD_SYSTEM_PROBE_ENABLED=true"
    echo "    cap_add:"
    echo "      - SYS_ADMIN"
    echo "      - SYS_RESOURCE"
    echo "      - SYS_PTRACE"
    echo "      - NET_ADMIN"
    echo "      - IPC_LOCK"
    echo "    security_opt:"
    echo "      - apparmor:unconfined"
) /ecommworkshop/docker-compose-files/docker-compose-fixed-instrumented.yml
sed -i "/volumes:/a \ \ \ \ \ \ - /sys/kernel/debug:/sys/kernel/debug" /ecommworkshop/docker-compose-files/docker-compose-fixed-instrumented.yml

# workshop-specific environment
sed -i "s/env:ruby-shop/env:dd201/" /ecommworkshop/docker-compose-files/docker-compose-fixed-instrumented.yml
cp /ecommworkshop/docker-compose/docker-compose-fixed-instrumented.yml /ecommworkshop/docker-compose.yml
statusupdate configuration

statuscheck apikey
DD_API_KEY=`cat /root/.dd_api_key` /root/postlogs.py 3600 &

statusupdate logging
statusupdate complete