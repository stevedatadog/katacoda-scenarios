This Lab's CI/CD Pipeline
===

**TODO: This should be in the LMS, I think, rather than in the lab.**

In addition to the Storedog application you are familiar with from the first part of this course, this lab provides a complete CI/CD pipeline to work with. Looking back at the four major phases of a pipeline, the tools are:

| phase      | tool      |
| ---        | ---       |
| Source     | Gogs      |
| Build      | Drone     |
| Staging    | Docker    |
| Production | Docker    |

Source
---
Gogs is an open source clone of GitHub that supports git hooks, which will allow you to automate actions when you commit code to the repository. The Storedog discounts service code will live in the Gogs repository.

Build
---
Drone is an open source continuous integration platform that will respond to git hooks from Gogs. When you commit changes to the discounts service repository, Drone will build a new Docker image of the discounts service using the latest code from Gogs.

Staging
---
Drone can automate most of a continuous integration pipeline, so it'll also deploy newly-built Docker images to staging. In the lab, "staging" will be differently named containers running on the same host.

Production
---
Once your code changes pass testing on staging, Drone will deploy the newly-built image to production. 

Synthetics Tests
---
All of the above automation is already configured in the lab, so you won't be distracted by the details. Instead, you will focus on creating an end-to-end browser test to cover the full customer checkout flow for Storedog. Once you are able to run this test manually to confirm that the staging and production deployments are regression-free, you will use the Datadog Synthetics CI API to automatically run the end-to-end test after each deployment. 

