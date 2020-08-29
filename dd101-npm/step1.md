In this Lab, we'll enable Network Performance Monitoring in a basic e-commerce application running in Docker. Storedog consists of the following services:

| Service        | Purpose |
| ---            |         |
| agent          | The Datadog Agent, which will collect metrics from all of the services and send them to the Datdog platform |
| discounts      | Python Flask API that serves store item discounts |
| frontend       | Spree, an open source e-commerce framework written in Ruby |
| advertisements | Python Flask API that serves advertisements |
| db             | PostgreSLQ database used by all services |

Let's take a look at the docker-compose configuration file to see how we enabled Network Monitoring for Storedog. Click on the IDE tab and give it a few seconds to load. Then expand the `lab` directory and open the file `docker-compose.yml`.

NPM is enabled by configuring the Datadog Agent service, `agent`. This docker-compose file has already been configured according to the instructions in the [NPM Installation documentation](https://docs.datadoghq.com/network_performance_monitoring/installation/?tab=docker): 

  - Under `environment`, we added `DD_SYSTEM_PROBE_ENABLED=true`
  - Under `volumes`, we added `/sys/kernel/debug:/sys/kernel/debug`
  - We added the `cap_add` section to allow the container to access host resources
  - We added the `security_opt` section to avoid AppArmor restrictions

Configuring NPM on a host, Kubernetes, or ECS is similar, and covered in the NPM Installation documentation.

In the next step, we'll start up the application and generate some network traffic to observe in the Datadog App.
