Course Introduction
===
In this course you're going to work with Storedog, a fully functional e-commerce application running on a few Docker containers managed by Docker Compose. You may be familiar with Storedog if you have completed other Datadog courses in the Learning Center. It's a great application for learning about Datadog because it consists of a variety of common web application technologies. Here's a summary of the services that comprise Storedog:

| Service        | Purpose |
| ---            | ---        |
| agent          | The Datadog Agent, which will collect metrics from all of the services and send them to the Datadog platform. This is where NPM is enabled |
| discounts      | Python Flask API that serves store item discounts |
| frontend       | Spree, an open source e-commerce framework written in Ruby |
| advertisements | Python Flask API that serves advertisements |
| db             | PostgreSQL database used by all services |

This course will walk you through incorporating synthetic tests into a CI/CD pipeline. You will trigger a browser test using curl and the `datadog-ci` command line client. Then you will configure the pipeline to run the test against a staging instance of Storedog before deploying to the production instance.

By the conclusion of this course, you will be able to:
  - Trigger synthetic tests and poll for their results with direct requests to the API for synthetics
  - Use the `datadog-ci` command line client to simplify running tests and viewing results
  - Integrate synthetic tests into your CI/CD pipeline using `datadog-ci`

Click the **Next** button below to get started.
