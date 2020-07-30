### In Terminal 1 
Change the working directory with the command `cd lab/ecommworkshop/docker-compose-files`{{execute}}. 

Enter the following, where `<DD_API_KEY>` is your Datadog API key. *Note: this is a temporary development step until this workshop lives at labs.datadoghq.com.*

```bash
export DD_API_KEY=<DD_API_KEY>
```

Now run this command to start up the Storedog application:

`POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres docker-compose -f docker-compose-fixed-instrumented.yml up`{{execute}}

Once docker-compose has started the Storedog app, you will see a stream of log output in Terminal 1.

You can interact with the Storedog app by clicking on the Storedog tab. It may take a minute or two to display.

You can generate traffic to the Storedog app using the [GoReplay](https://github.com/buger/goreplay) utility. 

### Open Terminal 2 
Change the working directory with the command `cd lab/ecommworkshop`{{execute}}

Then run the command `./gor --input-file-loop --input-file requests_0.gor --output-http "http://localhost:3000"`{{execute}}

In a few minutes you will see metrics in the Datadog app.

### Enabling Real User Monitoring (RUM)

Now we're going to want to enable RUM data to come into the platform.

1. [Create a new application](https://app.datadoghq.com/rum/list) in Datadog. 
  - Give it a name, such as Storedog
  - Click **Generate Client Token**
2. In the **Start collecting data section**, copy the `applicationId` and `clientToken` from the block of JavaScript code.
3. If docker-compose is running, stop it by typing CTRL-C in the first Terminal. 
4. Set these values in the first Terminal of your lab environment:
    ```bash
	  export DD_APPLICATION_ID=<applicationId>
	  export DD_CLIENT_TOKEN=<clientToken>
	  ```
5. Start (or restart) docker-compose. It will pass these newly added environment variables to the `frontend` container on startup.
6. Click around the Storedog user interface, or run the GoReplay command to generate traffic to the Storedog frontend.
