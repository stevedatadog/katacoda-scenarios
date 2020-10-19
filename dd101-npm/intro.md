Datadog's Network Performance Monitoring (NPM) provides multi-cloud visibility into network flows in granular detail, while also enabling you to aggregate and monitor that data using any tag available in Datadog. So you can query and aggregate connection metrics between any two objects—from services to availability zones, or from Kubernetes pods to security groups—to provide immediate insight into performance and dependencies.

NPM is built on eBPF, which enables detailed visibility into network flows at the Linux kernel level. Consequently, NPM is powerful and efficient with extremely low overhead.

In this lesson, you're going to learn: 
- How to enable NPM in a Datadog Agent Docker container 
- How to view NPM metrics between services in the Datadog App
- How to view the Network Map in the Datadog App
- How to use NPM to detect networking problems with a service

For this lab, you'll use NPM with the Storedog e-commerce app, running in a docker-compose environment. The principles will apply to any environment running on a Linux kernel.