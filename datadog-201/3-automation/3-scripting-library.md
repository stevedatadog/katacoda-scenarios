There are many programming language libraries, called "client libraries," that simplify communicating with the Datadog API. You can use them to easily add Datadog API requests to most applications, from internal administrative tools to native mobile consumer applications. Client libraries unlock the full power of the Datadog API using the programming languages that best fit your needs or preferences.

### a Python example
Click the IDE tab and wait for it to fully load. Then open `lab/scripts/poll_service.py`{{open}}.

This is a python script that uses the official Datadog client library for Python. It performs the same function as `poll_service.sh` from earlier in the lab. 

On line X, the script imports the `initialize()` function and the `api` object from the datadog client library. This is library you installed in the previous step that includes Dogshell.

On line X, `initialize()` is called to configure the library. If no arguments are given to it, `initialize()` will look for your API and application keys in the current environment the same way Dogshell does.

On lines X-Y, environment variables are assigned to local variables. This makes the script flexible and useful for different service and contexts, as `poll_service.sh` did.

On lines X-Y, the script calls `api.Metric.query()` in a loop, passing in the same query used in `poll_service.sh`. If the `series` array the JSON response contains values, the loop will break and the script will continue exiting.

On lines X-Y, finally, the script calls `api.Event.create()` to send the same event that `poll_service.sh` and Dogshell did. However, it adds the embellishment of a `source:python` tag which will replace Bits with the Python logo in the event stream.

Look at the [Python Client documentation](https://datadogpy.readthedocs.io/en/latest/) to learn about its capabilities. It's one of the few libraries can communicate with both the Datadog API and [DogStatsD](https://docs.datadoghq.com/developers/dogstatsd), a metrics aggregation service bundled with the Datadog Agent. 

### Other languages
Take a look at the [list of client libraries](https://docs.datadoghq.com/developers/libraries/) to see what's available for your language of choice. Also note that there are many special purpose Datadog libraries, such as those for serverless, log management, Google Analytics, and even Jira to name a small set. 

Click the **Continue** button use Terraform to provision an application stack and its monitors and dashboards at the same time.
