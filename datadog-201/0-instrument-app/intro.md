The first two parts of this course rely on Real User Monitoring (RUM) data. The Datadog agent service takes care of all the backend metrics that Storedog has been instrumented for, but it has no access to users' browser events that comprise RUM metrics. This must be configured manually.

In this lab, you will create a RUM application in the Datadog App. You will then configure the Storedog frontend service to use the RUM application's id and client token to send metrics to it. Finally, you'll generate some user events by exploring Storedog, and confirm that RUM is working correctly.

Click the **Start Scenario** button get started.