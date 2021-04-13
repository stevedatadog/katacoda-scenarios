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

`POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres docker-compose up`{{execute}}

Once docker-compose has started the Storedog app, you will see a stream of log output in Terminal 1.

You can interact with the Storedog app by clicking on the Storedog tab. It may take a minute or two to display. If you see a page displaying "Connecting to Port 3000," wait a little while and then refresh your browser.

### Open Terminal 2

Change the working directory with the command `cd ecommworkshop`{{execute}}

Let's generate traffic to the Storedog app using the [GoReplay](https://github.com/buger/goreplay) utility by running the command `./gor --input-file-loop --input-file requests_0.gor --output-http "http://localhost:3000"`{{execute}}

In a few minutes you will see data in the Datadog app.