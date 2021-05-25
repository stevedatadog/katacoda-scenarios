There are many programming language libraries, called "client libraries," that simplify communicating with the Datadog API. You can use them to easily add Datadog API requests to most applications, from internal administrative tools to native mobile consumer applications. Client libraries unlock the full power of the Datadog API using the programming languages that best fit your needs or preferences.

## A Python example
If you didn't install the Datadog for Python in the previous step, do so now:

`pip install datadog`{{execute}}

Click the IDE tab and wait for it to fully load. Then open `lab/scripts/poll_service.py`{{open}}.

This is a python script that uses the official Datadog client library for Python. It performs the same function as `poll_service.sh` from earlier in the lab. 

On line 5, the script imports the `initialize()` function and the `api` object from the datadog client library. This is the library that you installed in the previous step that includes Dogshell.

On line 7, `initialize()` is called to configure the library. If no arguments are given to it, `initialize()` will look for your API and application keys in the current environment the same way Dogshell does.

On lines 11-21, environment variables are assigned to local variables. This makes the script flexible and useful for different service and contexts, as `poll_service.sh` did.

On lines 26-32, the script calls `api.Metric.query()` in a loop, passing in the same query used in `poll_service.sh`. If the `series` array the JSON response contains values, the loop will break and the script will continue exiting.

On lines 37-41, the script prepares the arguments for `api.Event.create()` and calls it. This will send the same event that `poll_service.sh` and Dogshell did. 

### Run the script
Now that you're familiar with how this script works, run it in the terminal:

`cd /root/lab/scripts && ./poll_service.py`{{execute}}

The experience and outcome should be nearly identical to that of running `poll_service.sh`. You can check your events stream in the Datadog app to confirm that there's a new **redis-session-cache-is-up** event.

### More about the Python library
Look at the [Python Client documentation](https://datadogpy.readthedocs.io/en/latest/) to learn about its capabilities. It's one of the few libraries can communicate with both the Datadog API and [DogStatsD](https://docs.datadoghq.com/developers/dogstatsd), a metrics aggregation service bundled with the Datadog Agent. 

### Other languages
Take a look at the [list of client libraries](https://docs.datadoghq.com/developers/libraries/) to see what's available for your language of choice. Also note that there are many special purpose Datadog libraries, such as those for serverless, log management, Google Analytics, and even Jira to name a small set. 

### Conclusion
The python script in this lab is a good example of how Datadog client libraries work generally. You'll find that the official Datadog client libraries are the most comprehensive and up-to-date. If the client libraries for you language of choice are missing features that are important to you, remember that you can always fall back on making direct HTTP requests to the Datadog API.

Click the **Continue** button use Terraform to provision an application stack and its monitors and dashboards at the same time.