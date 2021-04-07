Suppose you have an executive who is interested in getting regular updates about the health of your services. Rather than sending a manual update every month, you instead create a self service executive dashboard.

### Step 1 - Top level metrics

This could be anything, but for the sake of argument, let’s say it’s:
1. Revenue
2. Checkout uptime

To create a revenue metric we will first need to find that data.

#### Create your Dashboard

We are going to start off with a blank screenboard by
1. Navigating to the **Dashboards**
2. Choosing **New Dashboard**
3. Adding a dashboard title, like `Store Service Overview`
4. Selecting **New Screenboard**

*Don't forget to ★ your screenboard to easily find it again.*

#### Create your revenue metric
Start by navigating to [Logs Explorer](https://app.datadoghq.com/logs) and searching for `service:store-cartlogger`{{copy}}

Once you’re confident this is the data that will allow you to track revenue, you’re going to want to store that metric over time.

- Create a measure on your **price** and **cost** by clicking on the item and selecting **Create measure for @item.price** and **@item.cost**
- Start by copying your query, `service:store-cartlogger`{{copy}}
- Navigate to **Generate Metrics** under the Logs navigation item
- Select **New Metric**
- Paste your query `service:store-cartlogger`{{copy}}
- Under `Count`, choose one of the measures you just created (`item.price` or `item.cost`)
- Finish by choosing **Create Metric**

Now that you’ve created your metric,
- Select **See in Metric Explorer** by hovering over the metric and clicking the graph icon
- From here you can view your new metric
- Get started with our Executive Dashboard by choosing **Export to existing dashboard**
- Select the name of the screenboard you created earlier (`Store Service Overview`) and click **Export**

Up next... Create your checkout uptime metrics
