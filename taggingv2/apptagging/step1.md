In the terminal on the right, the Storedog app is being brought online and is being instrumented for monitoring with Datadog. Live traffic to the app is also being simulated. This may take up to 2 minutes.

Once the app is running, you will see the message `Provisioning Complete` in the terminal along with your Datadog login credentials.

While you wait for the environment to be prepared, you can explore the assigned tags for the application.

1. Click `docker-compose-broken.yml`{{open}} to view the file in the editor on the right. 

    The docker-compose.yml instruments the Datadog agent and application for monitoring with Datadog.

    All <a href="https://docs.datadoghq.com/agent/docker/?tab=standard" target="_datadog">configuration in a Docker environment</a> is done through environment variables, volumes, and Docker labels.

    Because the application is run in a Docker (containerized) environment, the Datadog Agent runs in a container alongside the application containers: `agent`. 
     
    Each application service runs in its own Docker container: `discounts`, `frontend`, `advertisements`, and `db`.

2. Scroll through the file to view the configurations and tag assignments. 

    **Line 12** assigns the `env` tag to the application. By assigning this tag, all data coming in from the Storedog application is labeled as belonging to the same environment. (To learn more, view the <a href="https://docs.datadoghq.com/agent/docker/?tab=standard#environment-variables" target="_blank">Docker Agent Setup</a> documentation.) 
    
    **Lines 11, 48, 77, and 105** assign `team` tags to the data from the discount service, frontend service, and advertisements services. (To learn more, view the <a href="https://docs.datadoghq.com/tagging/assigning_tags/?tab=agentv6v7#environment-variables" target="_blank">Assigning Tags</a> documentation.) 
    
    **Lines 20, 44, 73, 101, and 113** assign labels as tags to the logs for the datadog agent, discount service, frontend service, advertisements services, and postgres, respectively. (To learn more, view the <a href="https://docs.datadoghq.com/agent/docker/log/?tab=dockercompose#activate-log-integrations" target="_blank">Docker Log Collection</a> documentation.)
    
    **Lines 27-29, 45-47, 54-56, 74-76, 84-86, and 102-104** assigns the `env`, `service`, and `version` tags to the services for <a href="https://docs.datadoghq.com/getting_started/tagging/unified_service_tagging?tab=docker" target="_blank">unified service tagging</a>. Unified service tagging ties together Datadog telemetry using these three reserved tags. It is recommeded that you set the `DD_ENV`, `DD_SERVICE`, and `DD_VERSION` environment variables and the corresponding Docker labels for each container of interest to ensure that all metric, trace, and log data collected from the container has these three tags.

3. Click `store-frontend-broken-instrumented/store-frontend/config/initializers/datadog.rb `{{open}} to view the file that instruments rails for tracing ruby applications. 

    The `service` tags for the `store-frontend`, `store-frontend-cache`, and `store-frontend-sqlite` are assigned here. (To learn more, view the <a href="https://docs.datadoghq.com/tracing/setup/ruby/#rails" target="_blank">Tracing Ruby Applications</a> documentation.)

4. After you see the `Provisioning Complete` message in the terminal, click the **storedog** tab on the right to view the Storedog app. 

    As you can see, the app includes a home page, product pages, advertisements, discounts, and a cart.

Now that the app is ready, let's start exploring the application data in Datadog.