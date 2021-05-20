Get familiar with the Datadog API by using cURL to query for metrics and post to the event stream.

This is the architecture of the small Docker container web application that you're going to provision and monitor:

| service  | service tag         | description                           |
| ---      | ---                 | ---                                   |
| stately  | stately-app         | a small Python Falcon web application |
| redis    | redis-session-cache | caches users' stately sessions        |
| agent    | agent               | Datadog agent                         |

The environment for this lab is `dd201`.

### Is redis running?
There are many ways you could answer this question if a Datadog Agent knows about the service. For example, you could look at the Redis - Overview dashboard, search for its tags in recent logs, or look for its container in the Docker Overview dashboard. If you have access to the host it's running on, there are many more ways to find out. 

One way to find out from the comfort of the command line is to use cURL to query the Datadog API. Start by looking at the [API Reference](https://docs.datadoghq.com/api/latest/) for an endpoint that might answer that question. 

The Logs endpoint might be a candidate, assuming the service is logging. A better assumption is that the service will send metrics to Datadog through the Datadog Agent. Looking at the metrics endpoint, [Query timeseries points](https://docs.datadoghq.com/api/latest/metrics/#query-timeseries-points) looks good. It will return an array of metric data points according to the query you specify. 

### Building an API URL
The documentation tells you the HTTP Method, the URL, and the required query string parameters. The URL with placeholders will be:

`https://api.datadoghq.com/api/v1/query?from=$FROM&to=$TO&query=$QUERY`

To determine the query string parameter values, determine what you want from this endpoint.  A good start is, "in the past minute, are there any core redis data points from the service redis-session-cache in the environment dd201?"

The command line tell will help you figure out what `$TO` is; it will be the UNIX timestamp when the request is made. `$FROM` will be 60 seconds before that.

`$QUERY` is a little tricky if you're new to Datadog metric queries. The main [Metrics documentation](https://docs.datadoghq.com/metrics/#querying-metrics) has a useful section about constructing queries.

The Datadog Metrics Explorer can also help you construct a query, if you know the metric you want. Looking at the **Metrics** tab of the [Redis integration](https://app.datadoghq.com/account/settings#integrations/redis), `redis.cpu.sys` stands out. If Redis is using system CPU, it's definitely running! Plug the metric name and tags into the Metric Explorer:

![Building a query in the Metric Explorer](./assets/building_explorer_query.png)

(The service was running in the above screenshot to provide a visual confirmation that it works. You won't see a graph.)

You can click the **export icon** in the upper right corner of the graph and select **Copy query to clipboard** to see it:

`[{"q":"avg:redis.cpu.sys{env:dd201,service:redis-session-cache}","type":"line"}]`

Taking only the value for `q` from that JSON object, you can now assemble your full URL to the Datadog API. `$FROM` and `$TO` will be filled in later:

`https://api.datadoghq.com/api/v1/query?from=$FROM&to=$TO&query=avg:redis.cpu.sys{env:dd201,service:redis-session-cache}`

### Making the request
Scroll down to the **Code Example** in the API documentation for the **Query timeseries points** endpoint. Note the tabs illustrating how to use language libraries to perform requests to this endpoint. This is a useful resource through the entire API documentation. 

Click on the **Curl** tab if it's not already selected. Note that in addition to a URL, the requests requires three headers: `Content-Type`, `DD-API-KEY`, and `DD-APPLICATION-KEY`. This is true for all API requests. The API and APP keys are already set in your environment, but you will have to set the `$FROM` and `$TO` variables. Putting it all together:

```
FROM=$(expr $(date +"%s") - 60)
TO=$(date +"%s")
curl -s -X GET "https://api.datadoghq.com/api/v1/query?from=$FROM&to=$TO&query=avg:redis.cpu.sys\{env:dd201,service:redis-session-cache\}" \
    -H "Content-Type: application/json" \
    -H "DD-API-KEY: ${DD_API_KEY}" \
    -H "DD-APPLICATION-KEY: ${DD_APP_KEY}"
```{{execute}}

Click the above code to execute it in the terminal.


```sh
#!/usr/bin/bash
REDIS_UP=false
while [ $REDIS_UP == false ]
do
  FROM=$(expr $(date +"%s") - 60)
  TO=$(date +"%s")
  sleep 2
  echo 'Waiting for redis...'
  REDIS_UP=$(curl -s -X GET "https://api.datadoghq.com/api/v1/query?from=$FROM&to=$TO&query=avg:redis.cpu.sys\{env:dd201,service:redis-session-cache\}" \
    -H "Content-Type: application/json" \
    -H "DD-API-KEY: ${DD_API_KEY}" \
    -H "DD-APPLICATION-KEY: ${DD_APP_KEY}" |jq '.series|length>0')
done
echo 'Redis is up.'
```


It's certainly possible to run a bash script after provisioning that makes these requests and parses the results. It may be more humane to use a utility to do the heavy lifting for you. 

Click the **Continue** button to enjoy the convenience of dogshell.


