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

This course will familiarize you with the three types of Datadog's Synthetic Monitoring tests: API tests, multistep API tests, and browser tests. These tests are called "synthetic" because they simulate requests and actions your users make. 

You'll set up tests to monitor the health of the Storedog homepage and discounts API. Then you'll build a robust browser test that will ensure that the discounts service data is rendered correctly on the Storedog homepage.

By the conclusion of this course, you will be able to:
  - Explain what each of the Datadog synthetic test types is capable of
  - Create API tests and multistep API tests for HTTP services
  - Create a complex synthetic browser test
  - Configure actionable alerts that will notify the right people when a synthetic test fails 
