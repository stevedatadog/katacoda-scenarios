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

For simplicity, only the discounts service will be managed by this pipeline. Being a small service with few moving parts, it's ideal for illustrating the basic CI/CD pipeline in this lab. All of Storedog's services could be managed by this pipeline equally well.

Source
---
[Gogs](https://gogs.io/) is an open source clone of GitHub that supports git hooks, which will allow you to automate actions when you commit code to the repository. For simplicity, only the Storedog discounts service code will live in the Gogs repository.

Build
---
[Drone](https://www.drone.io/) is an open source continuous integration platform that will respond to git hooks from Gogs. When you commit changes to the discounts service repository, Drone will build a new Docker image of the discounts service using the latest code from Gogs. It will then push this image to the local [Docker registry](https://hub.docker.com/_/registry).

Staging
---
Drone can automate an entire continuous integration and deployment pipeline, so it'll also deploy newly-built Docker images to staging. In the lab, "staging" will be copies of the Storedog frontend and discounts services running on the same host. storedog-frontend-staging will listen on port 3030, and storedog-discounts-staging will listen on port 5151.

Production
---
Once your code changes pass testing on staging, Drone will deploy the newly-built image to production. In this lab "production" is the same Storedog application you have been interacting with in this course.

Synthetics Tests
---
All of the above automation is already configured in the lab, so you won't be distracted by the details. Instead, you will focus on integrating the browser test you created in the first part of this course into this pipeline. 

First, you'll trigger the browser test by calling the Datadog API from the terminal. Once you are able to run this test manually to confirm that the staging and production deployments are regression-free, you will use the datadog-ci command line utility to automatically run the end-to-end test after each deployment. If the test fails on staging, the pipeline will halt and production will be unaffected.

