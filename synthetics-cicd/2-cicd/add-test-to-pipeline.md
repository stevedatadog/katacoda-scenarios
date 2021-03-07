You now have a mechanism to halt the production deployment of the Storedog discounts service if a build doesn't pass a synthetic browser test. The next step is to integrate it into your pipeline.

Drone stores its configuration with the source code that it builds, in a file named `.drone.yml`. When it receives the webhook event from Gogs, it checks out the affected repository and reads this file. 

Like most build systems, Drone halts when it encounters an error. As you saw in the previous step, `datadog-ci` will exit with an error code if the synthetic test it runs doesn't pass. Take a look at this file now. Click on the IDE tab and open the file `lab/discounts-service/.drone.yml`{{open}}.

The file consists of three sections divided by dashed lines. You will recognize these sections from the Drone activity details page: `build`, `deploy-staging`, and `deploy-production`. You don't need to know anything else about Drone specifically; each CI/CD tool is configured differently, but the concepts are the same. 

Add the following step to `deploy-staging` section of `.drone.yml`, after `restart`:

```
---
kind: pipeline
type: docker
name: test

steps:
  - name: datadog-synthetics
    image: node:15-alpine3.10
    commands:
      - yarn add --dev @datadog/datadog-ci
      - sleep 20
      - yarn datadog-ci synthetics run-tests --public-id $DD_PUBLIC_TEST_ID  --apiKey $DD_API_KEY --appKey $DD_APP_KEY
```



todo: move this to the next step in discussion about using variables for the start URLs:
To learn more about how you can use these files to create, trigger, and override synthetic tests, see the [CLI usage section](https://docs.datadoghq.com/synthetics/ci/?tab=apitest#package-installation) of the Datadog Docs for CI/CD Testing. 

    