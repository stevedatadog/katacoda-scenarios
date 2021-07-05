## A Tale of Two Libraries
Humans created the Datadog Python library that you used in the previous step in 2015. In addition to providing Python functions for most of the Datadog API, it comes with the Dogshell utility and modules for communicating with the Datadog Agent's DogStatsD metrics aggregation server. You can learn more about communicating with DogStatsD in the [library documentation](https://github.com/DataDog/datadogpy#dogstatsd).

It may seem odd to state that humans created the Datadog Python library, but this fact distinguishes it from the newer [datadog-api-client-python](https://github.com/DataDog/datadog-api-client-python).  datadog-api-client-python was programmatically generated from the Datadog API's OpenAPI specification, the same specification that generates the API Reference documentation. The advantage of generating the API client is that it is complete, predictable, and fully documented. An arguable disadvantage is that it can require more typing to use because it lacks the pithy nomenclature that humans are fond of. 

The documentation for the datadog-api-client-python [is here](https://datadog-api-client.readthedocs.io/en/latest/). The two functions you will look at in this lab are [`submit_log`](https://datadog-api-client.readthedocs.io/en/latest/v1/LogsApi/#submit_log) and [`list_logs`](https://datadog-api-client.readthedocs.io/en/latest/v1/LogsApi/#list_logs)

## Install datadog-api-client-python

Run this command in the terminal to install the library: `pip install git+https://github.com/DataDog/datadog-api-client-python.git`{{execute}}

## Posting log entries
Click on the IDE tab to the right and open `lab/scripts/submit_logs.py`{{open}} 

Lines 2-5 import the module dependencies.

Line 7 configures the client. Behind the scenes, `Configuration()` looks for `DD_API_KEY` and `DD_APP_KEY` in the environment to authenticate API calls. This is equivalent to `initialize()` in `poll_service.py` in the previous step.

Lines 9-10 set some local variables from the environment.

Lines 12 and 13 create a configured `LogsApi` instance.

Lines 14-29 create an `HTTPLog` instance containing two `HTTPLogItem` instances. You should recognize the `HTTPLogItem` arguments from the first lab, where you created log entries using Postman.

Line 33 brings everything together, calling `LogsApi.submit_log()` with the `HTTPLog` argument.

Lines 35-36 catch an `ApiException` and print its error message if the request fails.

Click on the Terminal tab and run the script: `/root/lab/scripts/submit_logs.py`{{execute}}

Take a look at your logs explorer to see the resulting log entries:

![Log  from Python script](./assets/log_entry_from_python.png)

## Querying log entries
Click on the IDE tab to the right and open `lab/scripts/list_logs.py`{{open}} 

**This section is in progress. Troubleshooting an issue with datetime ranges.**

## More about the Python libraries
Look at the [Python Client documentation](https://datadogpy.readthedocs.io/en/latest/) to learn about its capabilities. It's one of the few libraries that can communicate with both the Datadog API and [DogStatsD](https://docs.datadoghq.com/developers/dogstatsd), a metrics aggregation service bundled with the Datadog Agent. 

## Other languages
Take a look at the [list of client libraries](https://docs.datadoghq.com/developers/libraries/) to see what's available for your language of choice. Also, note that there are many special purpose Datadog libraries, such as those for serverless, log management, Google Analytics, and even Jira, to name a small set. 


Click the **Continue** button to wrap up this section.
