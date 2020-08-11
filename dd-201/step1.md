### In Terminal 1 
First, let's enable sending RUM data to to the platform.

[Create a new application](https://app.datadoghq.com/rum/list) in Datadog. 
  - Give it a name, such as Storedog
  - Click **Generate Client Token**

In the **Start collecting data section**, copy the `applicationId` and `clientToken` from the block of JavaScript code.

Set these values as environment variables in Terminal 1:
```bash
export DD_APPLICATION_ID=<applicationId>
export DD_CLIENT_TOKEN=<clientToken>
```

Now run this command to start up the Storedog application:

`POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres docker-compose up`{{execute}}

Once docker-compose has started the Storedog app, you will see a stream of log output in Terminal 1.

You can interact with the Storedog app by clicking on the Storedog tab. It may take a minute or two to display. If you see a page displaying "Connecting to Port 3000," wait a little while and then refresh your browser.

### Open Terminal 2 

Change the working directory with the command `cd ecommworkshop`{{execute}}

Let's generate traffic to the Storedog app using the [GoReplay](https://github.com/buger/goreplay) utility by running the command `./gor --input-file-loop --input-file requests_0.gor --output-http "http://localhost:3000"`{{execute}}

In a few minutes you will see metrics in the Datadog app.