This Lab environment is running three web servers (web1, web2, and web3) behind a load balancer (lb). We will generate traffic across these hosts by running scripts in the main Lab instance (master). The Datadog Agent is already installed on all of these instances, but we will need to enable network performance monitoring on each of the hosts. 

Let's start by enabling the Network Performance Monitoring system probe on master. Make a copy of the example configuration file:

`cp /etc/datadog-agent/system-probe.yaml.example /etc/datadog-agent/system-probe.yaml`{{execute}}

In this lab the system path `/etc/datadog-agent/` has been linked to the current directory for your convenience. 

Open `datadog-agent/system-probe.yml`{{open}} in the editor and uncomment the `system_probe_config:` line, and the `enabled: false` line. Change that line to `enabled: true`. Your changes will save automatically.

Restart the Datadog Agent with the command `datadog-agent restart`{{execute}}.

Log in the the Datadog app and select **Infrastructure > Network** from the global navigation. If you have not already enabled this feature, you will see the Discover Network Performance Monitoring introductory screen. Click the **Get Started** button in the upper-right corner to...

Let's see how opening terminals with a click works.

First, let's `ssh web1`{{execute T2}} and then run `datadog-agent version`{{execute T2}}
Next, let's `ssh web2`{{execute T2}} and then run `datadog-agent version`{{execute T2}}
Then, let's `ssh web3`{{execute T2}} and then run `datadog-agent version`{{execute T2}}
Finally, let's `ssh lb`{{execute T2}} and then run `datadog-agent version`{{execute T2}}