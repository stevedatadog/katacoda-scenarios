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

Part 1: Using Synthetic Tests to Catch Regressions
---
The first part of this course will familiarize you with the three types of Datadog's Synthetic Monitoring tests: API tests, multistep API tests, and browser tests. These tests are called "synthetic" because they simulate requests and actions your users make. 

You'll set up tests to monitor the health of the Storedog homepage and discounts API. Then you'll build a robust browser test that will ensure that the discounts service data is rendered correctly on the Storedog homepage.

By the conclusion of Part 1, you will be able to:
  - Explain what each of the Datadog synthetic test types is capable of
  - Create API tests and multistep API tests for HTTP services
  - Create a complex synthetic browser test
  - Configure actionable alerts that will notify the right people when a Synthetic Test fails 

Part 2: Synthetic Tests in a CI/CD Pipeline
---
The second part of this course will walk you through incorporating synthetic tests into a CI/CD pipeline. You will trigger the browser test from Part 1 using curl and the `datadog-ci` command line client. Then you will configure the pipeline to run the test against a staging instance of Storedog before deploying to the production instance.

By the conclusion of Part 2, you will be able to:
  - Trigger synthetic tests and poll for their results by making requests to the Datadog API for synthetics
  - Use the `datadog-ci` command line client to simplify running tests and viewing results
  - Integrate synthetic tests into your CI/CD pipeline using `datadog-ci`

Click the **Next** button below to get started.