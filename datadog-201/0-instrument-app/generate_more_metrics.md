Finally, generate a useful volume of traffic to the Datadog app using the [GoReplay](https://github.com/buger/goreplay) utility. This will run in a loop, making pre-recorded requests to Storedog to give you plenty of metrics to work with in the rest of the course.

Enter the following command in Terminal 2:

`/root/lab/gor --input-file-loop --input-file /root/lab/requests_0.gor --output-http "http://localhost:3000"`{{execute}}

In a few minutes you will see lots of data appear the Datadog app. **Navigate to Logs > Search** to see it in realtime.

Click the **Continue** button for some final words on setting up the environment for the course.