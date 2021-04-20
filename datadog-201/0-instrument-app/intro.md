In this course you're going to work with Storedog, a fully functional e-commerce application running on a few Docker containers. You may be familiar with Storedog if you have completed other Datadog courses in the Learning Center. It's a great application for learning about Datadog because it consists of a variety of common web application technologies. Here's a summary of the services that comprise Storedog:

| Service       | Purpose |
| ---           | ---     |
|agent          |The Datadog Agent, which will collect metrics from all of the services and send them to the Datadog platform |
|discounts      |Python Flask API that serves store item discounts |
|frontend       |Spree, an open source e-commerce framework written in Ruby |
|advertisements |Python Flask API that serves advertisements |
|db             |PostgreSQL database used by all services |

Part of this course relies on Real User Monitoring (RUM). The Datadog agent service takes care of all the backend metrics that Storedog has been instrumented for, but it has no access to users' browser events that comprise RUM metrics. This must be configured manually.

In this lab, you will create a RUM application in the Datadog App. You will then configure the Storedog frontend service to use the RUM application's id and client token to send metrics to it. Then you'll generate some user events by exploring Storedog, and confirm that RUM is working correctly.

Click the **Start Scenario** button get started.