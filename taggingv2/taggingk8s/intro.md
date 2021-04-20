Kubernetes creates dynamic environments by quickly spinning up containers with significantly shorter lifespans than physical hosts. Tagging is essential for monitoring data from Kubernetes deployments because large-scale applications and processes can be distributed across multiple ephemeral containers.

In Datadog, data from Kubernetes deployments can have native tags assigned through Integration Inheritance and custom tags assigned manually through various methods. You can use these tags throughout Datadog to work with your deployment data.

In this activity, you will assign and use tags to build container maps and dashboards in Datadog for a Kubernetes deployment.