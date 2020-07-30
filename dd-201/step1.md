### In Terminal 1 
Change the working directory with the command `cd ecommworkshop`{{execute}}. 

Now let's make sure that we enable RUM data to come into the platform

[Create a new application](https://app.datadoghq.com/rum/list) in Datadog. 
  - Give it a name, such as Storedog
  - Click **Generate Client Token**
  
In the **Start collecting data section**, copy the `applicationId` and `clientToken` from the block of JavaScript code.

Set these values in the first Terminal of your lab environment:
```bash
export DD_APPLICATION_ID=<applicationId>
export DD_CLIENT_TOKEN=<clientToken>
```

Now run this command to start up the Storedog application:

`POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres docker-compose up`{{execute}}

Once docker-compose has started the Storedog app, you will see a stream of log output in Terminal 1.

You can interact with the Storedog app by clicking on the Storedog tab. It may take a minute or two to display.

You can generate traffic to the Storedog app using the [GoReplay](https://github.com/buger/goreplay) utility. 

### Open Terminal 2 

Change the working directory with the command `cd ecommworkshop`{{execute}}

Then run the command `./postlogs.py 50 &`{{execute}}

You will now be able to see logs being sent to the Datadog app.

Then run the command `./gor --input-file-loop --input-file requests_0.gor --output-http "http://localhost:3000"`{{execute}}

In a few minutes you will see metrics in the Datadog app.

