Based on how the tags have been assigned, you can search the data using the tags and can jump between correlated metric, log, and trace data.

Let's explore the data for the Storedog app.

1. In a new browser window/tab, use the login credentials provided in the terminal to log in to the <a href="https://app.datadoghq.com/account/login" target="_datadog">Datadog account/organization</a> that was created for you for this activity.

    Note: If the credentials are not displayed in the terminal, run the command `creds`{{execute}} in the terminal.

2. If you have previously used **Logs** in the Datadog organization you are working in, you can move on to the next step. 

    If you are working in a new Datadog organization, you have to first enable **Logs** before you can continue. Navigate to <a href="https://app.datadoghq.com/logs" target="_datadog">**Logs**</a>. Click **Get Started**, then click **Get Started** again. You should now be able to see the Log List.

3. Navigate to <a href="https://app.datadoghq.com/apm/traces" target="_datadog">**APM** > **Traces**</a> in Datadog to view the list of traces that are coming in. 
    
    If you are working in a new Datadog organization, the link will be redirected to the **APM** > **Introduction** page. You may need to wait about two minutes as Datadog's Autodiscovery recognizes that trace data is coming in. In the main menu, when the option appears, click **APM > Traces** to see the list of traces.

4. In the search field above the list of traces, enter the following. 

    `env:ruby-shop`{{copy}} to make sure that you are only viewing traces for the Storedog app.

    `service:advertisements-service`{{copy}} to list traces for the advertisements service only.

    `resource_name:"GET /ads"`{{copy}} to list traces for this advertisements resource only.

    Note: You can also select these Facets from the list on the left. When you select the facet, you will see the tag appear in the search field.

5. Click any trace in the list to view its details. 

6. Below the Flame Graph, click through the **Infrastructure**, **Metrics**, and **Processes** tabs to see the metric data that is correlated to the trace data using the tags like `env`, `host`, and `service`.

7. Below the Flame Graph, click the **Logs (#)** tab to view the list of logs associated with this trace. 

    Notice the tag selected in the search field above the list of logs is the `trace_id` for the specific trace. You can configure log collection to include `trace_id` injection by Datadog.  To learn more, view the <a href="https://docs.datadoghq.com/tracing/connect_logs_and_traces/" target="_blank">Connect Logs and Traces</a> documentation. 

8. Click any of the logs. A new tab will open in **Logs** with the log details. 

    Notice the tag selected in the search field above the Logs List is the `trace_id` for the specific trace. 

9. Close the log details and clear the search field in Logs to list all the logs.

10. In the Logs search field, enter `env:ruby-shop`{{copy}} and `service:discount-service`{{copy}}.

11. Click any log in the list to view its details.

12. Near the top of the log details, click **Service** and then select **Go to APM Service Page**. The service page associated with the trace log will open in a new tab.

    Assigned tags like `env`, `host`, `service`, `trace_id`, etc. link related metric, trace, and log data in Datadog and allow you to quickly search for the data you need.

