## Enable Real User Monitoring
The executive dashboard you're going to create in this lab will depend on data created by users' interaction with the Storedog application. Datadog's Real User Monitoring, or RUM, uses a JavaScript library embedded in web pages to capture user actions and stream them to Datadog. To enable RUM for Storedog, you will do two things:
1. Create a RUM Application in the Datadog App to monitor Storedog user activity
2. Instrument Storedog by adding the Datadog RUM JavaScript library on every Storedog page

### Create a RUM Application
Now let's make sure that we enable RUM data to come into the platform.

[Create a new application](https://app.datadoghq.com/rum/list) in Datadog.
  - Give it a name, such as Storedog
  - Click **Generate Client Token**

In the **Start collecting data section**, copy the `applicationId` and `clientToken` from the block of JavaScript code.

### Instrument Storedog
Set these values in the first Terminal of your lab environment (without the `<` and `>` symbols):  
`export DD_APPLICATION_ID=<applicationId>`{{copy}}  
`export DD_CLIENT_TOKEN=<clientToken>`{{copy}}  

Now run this command to start up the Storedog application:

`docker-compose up`{{execute}}

Once docker-compose has started the Storedog app, you will see a stream of log output in Terminal 1.

You can interact with the Storedog app by clicking on the Storedog tab. It may take a minute or two to display. If you see a page displaying "Connecting to Port 3000," wait a little while and then refresh your browser.

Keep in mind that you are generating RUM metrics as you interact with Storedog, such as navigation events, click events, resource load times, and more. The more you interact with Storedog, the more RUM metrics you will generate!
### Generate More Metrics
Generate a useful volume of traffic to the Datadog app using the [GoReplay](https://github.com/buger/goreplay) utility:

`./gor --input-file-loop --input-file requests_0.gor --output-http "http://localhost:3000"`{{execute}}

In a few minutes you will see lots of data appear the Datadog app.

## Summary
The purpose of this lab was to show you how to instrument a web application from RUM while also getting familiar with Storedog. You also learned how this lab is automatically generating metrics for use in dashboards later. In future labs, all of this will be done for you so you can focus on the Datadog app.

Click the **Next** button to start building executive dashboards.