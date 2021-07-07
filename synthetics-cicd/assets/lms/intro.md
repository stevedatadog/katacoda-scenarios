In this course you're going to work with Storedog, a fully functional e-commerce application running on a few Docker containers managed by Docker Compose. You may be familiar with Storedog if you have completed other Datadog courses in the Learning Center. It's a great application for learning about Datadog because it consists of a variety of common web application technologies. Here's a summary of the services that comprise Storedog:

| Service        | Purpose |
| ---            | ---        |
| db             | PostgreSQL database used by all services |
| frontend       | Spree, an open source e-commerce framework written in Ruby |
| discounts      | Python Flask API that serves store item discounts |
| advertisements | Python Flask API that serves advertisements |
| agent          | The Datadog Agent, which will collect metrics from all of the services and send them to the Datadog platform. |

Note that the Datadog Agent is not required to run synthetic tests. However, it is required if you want to associate synthetic test results with APM traces. It is included in this lab so that you have metrics to explore in the Datadog app if you want to.

This course will walk you through incorporating synthetic tests into a CI/CD pipeline. You will trigger a browser test using curl and the datadog-ci command line client. Then, you will learn how to configure a pipeline to run your end-to-end test against a staging instance of Storedog before deploying to the production instance.

By the conclusion of this course, you will be able to:
- Create an end-to-end test to ensure a key functionality of your application works as expected
- Trigger synthetic tests on demand and poll for their results with direct requests to the Synthetics API
- Use the datadog-ci command line client to simplify running tests and viewing results 
- Integrate synthetic tests into an existing CI/CD pipeline using datadog-ci
- Use failed test results to troubleshoot a pipeline failure and quickly fix the issue 

Click the **Next** button below to get started.
