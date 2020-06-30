This Lab environment is running three web servers behind a load balancer. The Datadog Agent is already installed on these instances.

Log in the the Datadog app and select **Infrastructure > Network** from the global navigation. If you have not already enabled this feature, you will see the Discover Network Performance Monitoring introductory screen. Click the **Get Started** button in the upper-right corner to...

Let's see how opening terminals with a click works.

First, let's `ssh web1{{execute T2}}` and then run `datadog-agent version`{{execute T2}}
Next, let's `ssh web2{{execute T2}}` and then run `datadog-agent version`{{execute T2}}
Then, let's `ssh web3{{execute T2}}` and then run `datadog-agent version`{{execute T2}}
Finally, let's `ssh lb{{execute T2}}` and then run `datadog-agent version`{{execute T2}}