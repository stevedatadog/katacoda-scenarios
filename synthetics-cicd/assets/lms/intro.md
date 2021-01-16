Course Introduction
===

In this course you're going to be working with Storedog, a fully functional e-commerce application on a few Docker containers. You may be familiar with Storedog if you have completed other Datadog courses in the Learning Center. It's a great application for learning about Datadog because it consists of a variety of common web application technologies. Here's a summary of the services that comprise Storedog:

| Service        | Purpose |
| ---            |         |
| agent          | The Datadog Agent, which will collect metrics from all of the services and send them to the Datadog platform. This is where NPM is enabled |
| discounts      | Python Flask API that serves store item discounts |
| frontend       | Spree, an open source e-commerce framework written in Ruby |
| advertisements | Python Flask API that serves advertisements |
| db             | PostgreSQL database used by all services |

Part 1: Using Synthetic Tests to Catch Regressions
---
The first part of this course will familiarize you with the three types of Datadog's Synthetic Monitoring tests: API tests, multi-step API tests, and browser tests. You'll set up tests to monitor the health of the Storedog homepage and discounts API. Then you'll gradually build an end-to-end test that will cover a customer's complete checkout flow.

By the conclusion of Part 1, you will be able to:
  - Explain what each of the Datadog synthetic test types is capable of
  - Create a complex synthetic browser test to cover important flows through a web application
  - Configure actionable alerts that will notify the right people when a Synthetic Test fails 

Part 2: Synthetic Tests in a CI/CD Pipeline
---
The second part of this course will walk you through incorporating synthetic tests into a CI/CD pipeline. You will introduce a bug to the discounts service and "deploy" it to production in the labs on CI/CD pipeline. The synthetic browser test you created in Part 1 will alert you of the regression, but could you catch it sooner? You'll iterate on a couple strategies that will isolate regressions to a smaller canary deployment, and then integrate synthetic tests into your CI/CD pipeline to automatically catch regressions before they're even released!

By the conclusion of Part 2, you will be able to:
  - Understand the various points in a CI/CD pipeline where Datadog synthetic tests can catch regressions
  - Trigger synthetic tests using the Datadog API to run them on demand
  - Integrate synthetic tests into your CI/CD pipeline using Synthetics CI

Click the **Next** button below to get started.