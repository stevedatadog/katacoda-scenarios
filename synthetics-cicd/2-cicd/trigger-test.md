# Trigger the Browser Test
## Update the Test URLs
You're going to manually trigger the browser test you created in the first part of this course in a couple of different ways. Because this is a new lab, the Storedog frontend and discounts service URLs have changed. Update the global variables you created to store these values:
1. In the Datadog app, navigate to the [Synthetics Global Variables Page](https://app.datadoghq.com/synthetics/settings/variables)
1. Hover over the **FRONTEND_URL** variable and click on the pencil icon that appears on the far right
1. Under **Define variable**, change **Value** to the new Storedog frontend URL: `https://[[HOST_SUBDOMAIN]]-3030-[[KATACODA_HOST]].environments.katacoda.com/`{{copy}}
1. Click the **Save** button
1. Hover over the **DISCOUNT_URL** variable and click on the pencil icon that appears on the far right
1. Under **Define variable**, change **Value** to the new discounts service URL: `https://[[HOST_SUBDOMAIN]]-5001-[[KATACODA_HOST]].environments.katacoda.com/`{{copy}}
1. Click the **Save** button

Run the browser test now to confirm that it works with the new URL:
1. Navigate to **UX Monitoring > Synthetic Tests**
1. Click on the browser test you created in the first part of this course.
1. Click the **Run Test Now** button in the upper-right corner
1. Scroll down to **Test Results** and await the results.
## Get the Browser Test Id
Synthetic tests have 9-character alphanumeric public ids in the form of abc-def-ghi. You're going to need this to trigger the test using the API. You can find this code in the URL of the details page. For example, `https://app.datadoghq.com/synthetics/details/vn7-5ys-8jw`. Once you have it, set it as an environment variable in the terminal:

`export TEST_PUBLIC_ID=abc-def-ghi`

Note that the following steps assume that the environment variable `DD_API_KEY` is set to your API key, and `DD_APP_KEY` is set to your Application key. The lab already has these variables set. You can find your API key in the Datadog app under **Integrations > API Keys**. You can find the Application key under **Team > Application Keys**.
## Trigger The Test (The Hard Way)
First, trigger the browser test using cURL. This will illustrate how the API works at a low level. The workflow is to POST a request to trigger a test, and then to GET the results of the test. Click the following block of code to execute this request for your browser test:

```bash
curl -X POST \
-H 'Content-Type: application/json' \
-H "DD-API-KEY: ${DD_API_KEY}" \
-H "DD-APPLICATION-KEY: ${DD_APP_KEY}" \
-d '{
    "tests": [
        {
            "public_id": "${TEST_PUBLIC_ID}"
        }
    ]
}' "https://api.datadoghq.com/api/v1/synthetics/tests/trigger/ci"
```

The response will look something like this:

```json
{"batch_id":null,"results":[{"device":"chrome.laptop_large","result_id":"7425966295343615430","public_id":"vn7-5ys-8jw","location":30019},{"device":"firefox.laptop_large","result_id":"5281194447760414433","public_id":"vn7-5ys-8jw","location":30019}],"triggered_check_ids":["vn7-5ys-8jw"],"locations":[{"display_name":"N. California (AWS)","name":"aws:us-west-1","region":"Americas","is_active":true,"is_public":true,"id":30019}]}
```

This response contains information about how the test was run. If you look at the `results` array, you will see that a test was run for each device/location pair that you configured. There is a `result_id` for each test that you will need for the next step. Grab the first one and assign it to an environment variable:

`export TEST_RESULT_ID=0123456789`

Next, you need to make another call to get the results of the test:

```bash
curl -G \
    "https://api.datadoghq.com/api/v1/synthetics/tests/poll_results" \
    -H "DD-API-KEY: ${DD_API_KEY}" \
    -H "DD-APPLICATION-KEY: ${DD_APP_KEY}" \
    -d "result_ids=[${TEST_RESULT_ID}]"
```

If the test is complete, the results from this request will be quite large as it will contain all of the information about test that you would see in the Datadog app. If you visit the synthetic test's details page, you will see that ran just like all the other times you ran it. One difference is that the **RUN TYPE** will be **CI**:

![CI Run Type for API triggered test](./assets/test_results_ci_run_type.png)

The most important key in the result will be `passed`, a boolean value. You could halt the pipeline if this is `false`, or continue deploying if this is `true`. You can read more about the variety of API endpoints and their responses in the [Datadog API Reference for Synthetics](https://docs.datadoghq.com/api/latest/synthetics/).

The synthetics API opens the opportunity for custom test monitoring, triggering, and reporting. But working with it this way is not ideal for a lean, flexible, and easy to maintain pipeline. Fortunately, Datadog developed an open source CLI client to easily incorporate synthetic tests into CI/CD pipelines!

## Trigger The Test (The Easy Way)
The Datadog CLI client is a Node Package Manager module called [@datadog/datadog-ci](https://www.npmjs.com/package/@datadog/datadog-ci). It's already installed in the lab, so you can start using it immediately. The client will read any file in the same directory named `<anything>.synthetics.json` for information about the tests it will run. Start by creating one:

1. In the terminal, create an empty file by running the command `touch /root/cicd/discounts.synthetics.json`{{execute}}
1. Open the IDE and open the file you just created: `/root/cicd/discounts.synthetics.json`{{open}}
1. Paste the following JSON code into the file: 
   <pre class="file" data-filename="/root/cicd/discounts.synthetics.json" data-target="replace">
   {
     "tests": [
       {
         "id": "abc-def-ghi"
       }
     ]
   }
   </pre>
1. Replace "abc-def-ghi" with the public id of the browser test that you stored in `TEST_PUBLIC_ID`. 
1. In the terminal, run the command `yarn datadog-ci synthetics run-tests --apiKey $DD_API_KEY --appKey $DD_APP_KEY`{{execute}}

You will start seeing nicely formatted output as `datadog-ci` triggers the test and fetches the results. 

![datadog-ci running a browser test](./assets/datadog-ci-running-test.png)

To learn more about how you can use these files to create, trigger, and override synthetic tests, see the [CLI usage section](https://docs.datadoghq.com/synthetics/ci/?tab=apitest#package-installation) of the Datadog Docs for CI/CD Testing. 

    