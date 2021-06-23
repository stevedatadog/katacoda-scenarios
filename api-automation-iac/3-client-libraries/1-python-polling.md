There are many programming language libraries, called "client libraries," that simplify communicating with the Datadog API. You can use them to easily add Datadog API requests to most applications, from internal administrative tools to native mobile consumer applications. Client libraries unlock the full power of the Datadog API using the programming languages that best fit your needs or preferences.

## Polling metrics with Python
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

Click the **Continue** button to create events using the Python client library.