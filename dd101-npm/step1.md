In this Lab, we'll enable Network Performance Monitoring in a basic e-commerce application running in Docker. Storedog consists of the following services:

| Service        | Purpose |
| ---            |         |
| agent          | The Datadog Agent, which will collect metrics from all of the services and send them to the Datdog platform |
| discounts      | Python Flask API that serves store item discounts |
| frontend       | Spree, an open source e-commerce framework written in Ruby |
| advertisements | Python Flask API that serves advertisements |
| db             | PostgreSLQ database used by all services |

Let's get Storedog up and running now so Datadog can start collecting network data. In the Terminal tab, enter the following:

`docker-compose up -d`{{execute}}

Let's take a look at the docker-compose configuration file to see how we enabled Network Monitoring for Storedog. Click on the IDE tab and give it a few seconds to load. Then open the file `docker-compose.yml`{{open}}.

Let's start by enabling the Network Performance Monitoring system probe on master. Make a copy of the example configuration file:

Log in the the Datadog app and select **Infrastructure > Network** from the global navigation. If you have not already enabled this feature, you will see the Discover Network Performance Monitoring introductory screen. Click the **Get Started** button in the upper-right corner to...

Let's see how opening terminals with a click works.