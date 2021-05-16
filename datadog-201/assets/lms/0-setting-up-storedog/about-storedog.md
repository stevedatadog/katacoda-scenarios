For most of this course you're going to work with Storedog, a fully functional e-commerce application running on a few containers managed by Docker Compose. You may be familiar with Storedog if you have completed other Datadog courses in the Learning Center. It's a great application for learning about Datadog because it consists of a variety of common web application technologies. Here's a summary of the services that comprise Storedog:

| Service        | Purpose |
| ---            | ---        |
| db             | PostgreSQL database used by all services |
| frontend       | Spree, an open source e-commerce framework written in Ruby |
| discounts      | Python Flask API that serves store item discounts |
| advertisements | Python Flask API that serves advertisements |
| agent          | The Datadog Agent, which will collect metrics from all of the services and send them to the Datadog platform. |

Storedog is already instrumented for most of the metrics you will be using to create dashboards and notebooks. You will need to set up RUM yourself. 

In this module, you will create a RUM application, configure Storedog to use it, and then get familiar with the application while generating some metrics.

Click the **Next** button below to get started.

