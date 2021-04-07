### Step 2 - Choose your drill-down data

*This can be any type of data that you consider to be leading indicators of your top-level metrics*

Let's copy some pre-built RUM graphs: 
- Navigate to **RUM Explorer** under UX Monitoring or go click [this link](https://app.datadoghq.com/rum/explorer)
- Click **Dashboards** → **Performance**
- Choose the graphs that might explain changes in your top-level metrics

*If you're not seeing any RUM data, make sure to click around in the page to start seeing real-time data*

Let's also copy some re-built Docker graphs:
- Navigate to **Dashboard List** under Dashboards and find **Docker - Overview** or [click this link](https://app.datadoghq.com/screen/integration/52/docker---overview)
- Choose the graphs that might explain changes in your top-level metrics

Let's also create some drill-downs on our executive dashboards:
- Copy the URL for the RUM Performance `https://app.datadoghq.com/screen/integration/30292/RUM%20-%20Performance%20Overview?`{{copy}}
- Choose a **Notes & Link** links widget and paste the URL and save
- Open one of your widgets and follow the instructions to create a custom link
- Repeat as needed for the **Docker - Overview** or `https://app.datadoghq.com/screen/integration/52/docker---overview`{{copy}}
