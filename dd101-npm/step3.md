One of the metrics NPM provides is TCP retransmits. This occurs when a system that is sending TCP packets doesn't recieve timely acknowlegement from the recipient. If a system is retransmitting a lot of packets to a recipient, there is likley likely something wrong with the network connection between them.

**Retransmits** are displayed prominently in the Network view, along with **Volume Sent** and **Round-trip Time**. You likely don't see many retransmits for Storedog, as they are uncommon in such a small-scale application where all the services are on the same network. Let's create some to see what happens!

We'll use [Pumba](https://github.com/alexei-led/pumba), a "chaos testing tool" for Docker.  From the README.md: 

> Pumba disturbs your containers by crashing containerized application, emulating network failures and stress-testing container resources (cpu, memory, fs, io, and others).

Let's have Pumba lose 85% of the packets sent to `discounts-service` and see what happens.

1. Click on the Terminal 2 tab and change the directory to `lab/`: `cd lab`{{execute}}. 
2. Run this command to start a Pumba container that will disturb the container running `discounts-service` for 7 minutes:
    `docker run -it --rm  -v /var/run/docker.sock:/var/run/docker.sock gaiaadm/pumba --log-level=info netem --tc-image=gaiadocker/iproute2 --duration 7m loss ecommworkshop_discounts_1 --percent 85`{{execute}}

Now look at the Network view in the Datadog App. Data in this view updates every 5 minutes, so it may take a little while to see the results.