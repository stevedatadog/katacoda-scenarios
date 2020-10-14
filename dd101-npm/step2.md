# Explore the Application

Click the **Storedog** tab to the right of the IDE tab to open the application in a new window. It will take a little while for the first page to load. When it does, click around to get familiar with this e-commerce shop. Feel free to add items to your shopping cart and treat it like a real online store.

You may run into errors, such as `Net::OpenTimeout in Spree::HomeController#index`. This is a problem we're going to troubleshoot later!

Now that you're familiar with the application, you can run a pre-recorded loop of requests to it to simulate real traffic.  Click the **Terminal** tab and run GoReplay with the following command:

`./gor --input-file-loop --input-file requests_0.gor --output-http "http://localhost:3000"`{{execute}}

You may see errors in the terminal periodically, but that's OK.

# Observe the Network Metrics

Log in the the [Datadog App](https://app.datadoghq.com/) and select **Infrastructure > Network** from the global navigation. You will probably see the Discover Network Performance Monitoring introductory screen. This page is displayed until the first NPM data is process by Datadog, which can take up to 15 minutes. Note that you should not refresh this page to see if NPM data is available; click on the **Infrastructure > Network** menu item to check for updates.

Here you'll see network *flows* that Datadog has detected between the application services. A flow is a network connection between any two tagged objects--from services to availability zones, or from Kubernetes pods to security groups. 

@todo screenshot

The data represented in this page are updated every 5 minutes. *If you don't see anything yet, you may need to wait until the next update.* This would be a good time to read the Datadog [documentation about the Network Page](https://docs.datadoghq.com/network_performance_monitoring/network_page/).

For our Storedog application, you should see four flows between `advertisements-service`, `store-frontend`, and `discounts-service`. Each flow represents the network communication among these services where one is the Source, and another is the Destination. 

You may see flows where the source and destination are **N/A**. This represents traffic to or from an "untagged" resource, which is a client or server that is not running the Datadog Agent. In our case, this includes the GoReplay script running on the Docker host and your Storedog browser activity routed through the lab network. You can hide or display untagged traffic using the **Show N/A (Untagged traffic)** toggle in the **Filter Traffic** settings menu.

![Screenshot of the Filter Traffic settings menu with Show N/A toggled off](./assets/show_na_traffic_settings.png)

NPM can provide details of network traffic that is untagged. Expand the **Domain** facet to the left of the flow table and you'll see all the domains that NPM was able to resolve during the current time period. If you click on one of the domains, the flow table will filter the related flows. You can then click on the flow to see details about that flow.

![Screenshot of Domain facet and untagged flow details](./assets/untagged_flow_details.png)

You can hide untagged traffic by clicking on the **Filter Traffic** button, and turning off **Show N/A**. 

![Screenshot of Filter traffic toggle with Show N/A turned of](./assets/filter_traffic_toggles_v2.png)

To visualize these flows, navigate to **Infrastructure > Network Map**. This is a diagram of the same flows, where each service's size is scaled relative to the volume of network traffic it has sent. The connections between each service are also scaled to indicate what proportion of that volume was sent to each destination.

You can choose other metrics to scale the diagram using the **Metric** field in the upper-right hand corner. Select some other metrics to see how they affect the diagram, and what that diagram tells you about the application.

You can filter traffic on the Netowrk Map page by clicking the filter button in the upper-right corner. In addition to filtering based on traffic type, you can also set the range of the chosen metric that is displayed.

![Screenshot of Filter traffic panel with metric range selector](./assets/map_filters.png)

In the next step, we'll create some network problems and see how they appear on the Network page.



