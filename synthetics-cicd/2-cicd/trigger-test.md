## Update the Frontend URL
You're going to manually trigger the browser test you created in the first part of this course in a couple different ways. Because this is a new lab, the Storedog URL has changed. Update the URL for the browser test:
1. In the Datadog app, navigate to the [Synthetics Global Variables Page](https://app.datadoghq.com/synthetics/settings/variables)
1. Hover over the **FRONTEND_URL** variable and click on the pencil icon that appears on the far left
1. Under **Define variable**, change **Value** to the new Storedog frontend URL: `https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com/`{{copy}}
1. Click the **Save** button

Run the browser test now to confirm that it works with the new URL:
1. Navigate to **UX Monitoring > Synthetic Tests**
1. Click on the browser test you created in the first part of this course.
1. Click the **Run Test Now** button in the upper-right corner
1. Scroll down to **Test Results** and await the results.
## Get the Browser Test Id
Synthetic tests have 9-character alphanumeric public ids in the form of abc-def-ghi. You're going to need this to trigger the test using the API. You can find this code in the URL of the details page. For example, `https://app.datadoghq.com/synthetics/details/vn7-5ys-8jw`. Once you have it, set it as an environment variable in the terminal:

`export TEST_PUBLIC_ID=abc-def-ghi`
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

This response contains a lot of information about how the test was run. If you look at the `results` array, you will see that a test was run for each device/location pair that you configured. There is a `result_id` for each test that you will need for the next step. Grab the first one and assign it to an environment variable:

`export TEST_RESULT_ID=0123456789`

Next, you need to make another call to get the results of the test:

```bash
curl -G \
    "https://api.datadoghq.com/api/v1/synthetics/tests/poll_results" \
    -H "DD-API-KEY: ${DD_API_KEY}" \
    -H "DD-APPLICATION-KEY: ${DD_APP_KEY}" \
    -d "result_ids=[7425966295343615430]"
```

If the test is complete, the results from this request will be quite large. It will contain all of the information you see in the Datadog test results.

While the API creates the opportunity for completely custom synthetic test monitoring and reporting, it would take a lot of code parse the results. You want to keep the pipeline lean, simple, and fast. Fortunately, Datadog manages a CLI utility specifically for integration into a CI/CD pipeline!

## Trigger The Test (The Easy Way)
