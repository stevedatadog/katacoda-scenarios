In addition to the Storedog application described in the introduction, this lab provides a complete CI/CD pipeline to work with. Looking back at the four typical phases of a pipeline, the corresponding tools in this pipeline are:

| Phase      | Tool      |
| ---        | ---       |
| Source     | Gogs      |
| Build      | Drone     |
| Staging    | Docker    |
| Production | Docker    |

For simplicity, only Storedog's discounts service will be managed by this pipeline. Being a small service with few moving parts, it's ideal for illustrating the basic CI/CD pipeline in this lab. All of Storedog's services could be managed by this pipeline equally well.

Source
---
[Gogs](https://gogs.io/) is an open source clone of GitHub that supports git hooks, which will allow you to automate actions when you commit code to the repository. For simplicity, only the Storedog discounts service code will live in the Gogs repository.

Build
---
[Drone](https://www.drone.io/) is an open source continuous integration platform that will respond to git hooks from Gogs. When you commit changes to the discounts service repository, Drone will build a new Docker image of the discounts service using the latest code from Gogs. It will then push this image to the local [Docker registry](https://hub.docker.com/_/registry).

Staging
---
Drone can automate an entire continuous integration and deployment pipeline, so it'll also deploy newly-built Docker images to staging. In the lab, "staging" will be copies of the Storedog frontend and discounts services running on the same host, but on different ports. The deployment will be executed by pulling the newly-built discounts service, and then restarting the container.

Currently, the pipeline does not pause for testing after deploying to staging; it immediately deploys to production. This is where you will configure the pipeline to perform a browser test on staging, and only deploy to production if it passes.

Production
---
The production version of Storedog is the same as the one you tested in the first part of this course, listening on the same ports. Initially, the pipeline will deploy the newly-built and untested discounts service here immediately after staging, whether it works or not!

Synthetics Tests
---
Most of the above automation is already configured in the lab, so you won't be distracted by the details. Instead, you will focus on integrating a synthetic browser test into the staging step.

First, you'll trigger the browser test by calling the Datadog API from the terminal. Once you are able to run this test manually to confirm that the staging and production deployments are regression-free, you will use the datadog-ci command line utility to automatically run the test after each staging deployment. If the test fails on staging, the pipeline will halt and production will not be affected.

Click the **Next** button below to start working with the discounts service CI/CD pipeline.
