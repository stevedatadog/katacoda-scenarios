# Run the Storedog Application

Let's get Storedog up and running now so Datadog can start collecting network data. In the Terminal tab, click the following block of code to run it in the terminal:

`POSTGRES_USER=postgres POSTGRES_PASSWORD=postgres docker-compose up -d`{{execute}}

Once docker-compose finishes starting up, click the **Storedog** tab to the right of the IDE tab to open the application in a new window. It will take a little while for the first page to load. When it does, click around to get familiar with this e-commerce shop. Feel free to add items to your shopping cart and treat it like a real online store.

Now that you're familiar with the application, you can run a pre-recorded loop of requests to it to simulate real traffic.  Click the **Terminal** tab and run GoReplay with the following command:

`./gor --input-file-loop --input-file requests_0.gor --output-http "http://localhost:3000"`{{execute}}

You may see errors in the terminal periodically, but that's OK.

# Observe the Network Metrics

Log in the the [Datadog App](https://app.datadoghq.com/) and select **Infrastructure > Network** from the global navigation. If you have not already enabled this feature, you will see the Discover Network Performance Monitoring introductory screen. Click the **Get Started** button in the upper-right corner to enable NPM.

Here you'll see network *flows* that Datadog has detected between the application services. A flow is a network connection between any two tagged objects--from services to availability zones, or from Kubernetes pods to security groups. 

For our Storedog application, you should see four flows between `advertisements-service`, `store-frontend`, and `discounts-service`. Each flow represents the network communication among these services where one is the Source, and another is the Destination. 

*Note: The data represented in this view are updated every 5 minutes, so if you don't see anything initially you may need to wait until the next updated.*

To visualize these flows, navigate to **Infrastructure > Network Map**. This is a diagram of the same flows, where each service's size is scaled relative to the volume of network traffic it has sent. The connections between each service are also scaled to indicate what proportion of that volume was sent to each destination.

You can choose other metrics to scale the diagram using the **Metric** field in the upper-right hand corner. Select some other metrics to see how they affect the diagram, and what that diagram tells you about the application.

In the next step, we'll create some network problems and see how they appear on the Network page.



