You just discovered the root cause of an issue in your spree services using advanced dashboarding tools. To capture and share your knowledge, let's create a runbook that you can share with your team.
 
## Adding a Notebook
In your navigation bar, find the Notebook icon and click “New Notebook”, or click [this link](https://app.datadoghq.com/notebook). Give it a name like `Debugging Spree Services`{{copy}}.
 
Let’s start by adding an overview of your services. You can paste this overview that a teammate has already written.
 
<pre class="file" data-target="clipboard">
## Service Overview
`ads-service`: Service to manage advertisement scheduling and displays  
`discounts-service`: Service to manage discount codes and validation  
`store-frontend`: Service for the store’s web frontend  
</pre>
 
## Custom Troubleshooting
Next, let's add a link to the dashboard you used to debug your service. Since we worked on `store-frontend`, we can link to the [RUM Performance Overview](https://app.datadoghq.com/screen/integration/30292/rum---performance-overview?live=true) dashboard.
 
This is an out-of-the-box dashboard for real-user-monitoring (RUM) that monitors metrics like page views and frontend errors. We can clone it to make changes.  
 
For our spree services, we know that problems often happen in the production environment with frontend errors. Let’s set our template variable `env` to `prod`. This updates our dashboard URL.  
 
We can link to this dashboard in our runbook and add some context around it. Paste this into your runbook or add your own context:  
 
<pre class="file" data-target="clipboard">
[RUM Performance Overview for Prod](https://app.datadoghq.com/screen/integration/30292/rum---performance-overview?live=true&tpl_var_env=prod)
</pre>
