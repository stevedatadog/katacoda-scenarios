# The Storedog Application
In this Lab, you'll write Synthetic tests for Storedog, a basic, containerized e-commerce application running with Docker Compose. The lab is automatically provisioning the application, and you'll know that it's ready when you see "Provisioning Complete" in the terminal. You should also see the trial Datadog credentials the lab created for you in the terminal. Copy the username and password somewhere handy because' you'll need them shortly. You can display these credentials any time by entering the command `creds`{{execute}} in the terminal.

When provisioning is complete, you can click on the **Storedog** tab above the terminal to interact with the application. 

![The StoreDog e-commerce application home page](assets/storedog.png)

Click around Storedog as you would with a real e-commerce site. You can even add items to your shopping cart and check out, but Storedog won't actually ship you anything or charge your credit card. While you're getting familiar with the application the Datadog Agent container is sending metrics to Datadog.

## Datadog Metrics

Log in to [Datadog](https://app.datadoghq.com) using the trial credentials the lab created for you. You will see the Application Performance Monitoring (APM) Services page listing all of the services the Datadog Agent is reporting from the lab. 

![Storedog Services](assets/services.png)

To see how these services interact with each other, navigate to APM > Service Map. By filtering **Web** services, you can see that store-frontend communicates with advertisements-service and discounts-service. 

![Storedog Services Map](assets/services_map.png)

Storedog's frontend-service runs the web application. It makes requests to discounts-service to display promotional coupon codes to shoppers. It also uses this service to validate coupon codes that shoppers use during checkout. frontend-service makes requests to advertisements-service to display product ads on the home page and on product pages. You can see a coupon code and an advertisement outlined in this screenshot:

![Storedog coupon code and advertisement](assets/discount_and_ad.png)


Storedog's different services are sending logs to datadog to report their activity.
We can see logs from the frontend, from the ads service, and from the discounts service.
Logs are especially useful to troubleshoot problems. When you are not sure of the origin of the issue, you can filter by errors and look for patterns.

[Logs: https://app.datadoghq.com/logs](https://app.datadoghq.com/logs)

![Datadog Logs Explorer page](assets/logs.png)

The different services are also available individually in APM.
It's useful to have a birds-eye view of all of the services or to focus on the current status of a single service.
And to troubleshoot problems, the traces can help to pinpoint the problem to a specific function in the code.

[Service list: https://app.datadoghq.com/apm/services](https://app.datadoghq.com/apm/services)

![Datadog APM Services page](assets/apm.png)

APM even builds a map of the different services to understand their interactions and their current activity.

[Service map: https://app.datadoghq.com/apm/map](https://app.datadoghq.com/apm/map)

![Datdog APM Service Map page](assets/service-map.png)
