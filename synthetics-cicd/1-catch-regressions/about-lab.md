# The Storedog Application
In this Lab, you'll write Synthetic tests for Storedog, a basic, containerized e-commerce application. You'll use Docker Compose to run the containers in a simulated production environment. Storedog consists of the following services:

## CI/CD Pipeline

For this lab, we have simulated a Continuous Integration / Continuous Deployment (CI/CD) pipeline. In the real world, a CI/CD pipleline would automatically detect changes to production code in a repository, run tests on that code, and if the tests paass, deploy the code changes to production.

We'll get into the details of how our simulated pipeline works in the second half of this course. 

## Deploy

To "deploy" Storedog using our simulated CI/CD pipeline, run `git push deploy`{{ execute }} in the Terminal.

Once everything is running, you should be able to visit the store by clicking on `storedog` in the tabs. Be patient, as it may take a while for the first page to render.

![The StoreDog ecommerce application home page](assets/storedog.png)

## See Traffic in Datadog

The application is now running and instrumented.
After browsing some pages, we should be able to see some traffic in datadog.

The different services composing our application are sending logs to datadog to report their activity.
We can see logs from the frontend, from the ads service, and from the discounts service.
Logs are especially useful to troubleshoot problems. When you are not sure of the origin of the issue, you can filter by errors and look for patterns.

[Logs: https://app.datadoghq.com/logs](https://app.datadoghq.com/logs)

![Datadog Logs Explorer page](assets/logs.png)

The different services are also available individually in APM.
It's useful to have a birds-eye view of all of the services or to focus on the current status of a single service.
And to troubleshoot problems, the traces can help to pinpoint the problem to a specific function in the code.

[Service list: https://app.datadoghq.com/apm/services](https://app.datadoghq.com/apm/services)

![Datadog APM Services page](assets/apm.png)

APM even builds a map of the different services to understand their interactions and their current activity.

[Service map: https://app.datadoghq.com/apm/map](https://app.datadoghq.com/apm/map)

![Datdog APM Service Map page](assets/service-map.png)
