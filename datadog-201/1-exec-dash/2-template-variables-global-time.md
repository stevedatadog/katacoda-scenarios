### Template Variables
There are a couple problems with the widgets you copied in the previous step. First, the RUM widgets seem to have lost their data. To find out why, hover over the **Number of sessions by country** widget and click the **pencil icon** to edit the widget. Under **Graph your data**, take a look at the query: ![Geomap query with template variables](./assets/geomap_template_vars.png)

The search query depends on several template variables, such as `$service`, `$version`, and so on. These variables were set to defaults in their native dashboard, and allowed users to select specific tag values by which to filter the underlying metrics. You can see the variable selectors at the top of the Rum - User Sessions dashboard: ![Rum user session template variables](./assets/rum_session_template_vars.png)

One option would be to add all of these template variables to the Storedog Executive Dashboard. But Storedog is such as small application that this level of filtering is unnecessary. Instead, delete all of the variables in the geomap query except for `$env`. ![Just the env, please](./assets/env_dd201_geomap_var.png)

Click the **Save** button. 

Now,  add the `env` template variable to the dashboard. Just under the dashboard title, click **Add Template Variables**. For **Name**, enter "env".

For **Tag or Attribute**, start typing "env" and then select **env** from the filtered list of tags.  ![Creating env template var](./assets/setting_env_template_var.png)

Click the **Done** button.

Now you can set the dashboard view to either `*`, which will display metrics tagged with *any* `env` value, or `dd201`, which will display metrics tagged *only* with `env:dd201`. This is useful if you have used this account for other Learning Center labs with different `env` tag values. A real world use for this variable could be to switch among values tagged with `env:production`, `env:staging`, or `env:development`.

Next, update the **Performance overview of most popular pages** widget to use only the `$env` template var: ![Use only env in the page performance widget](./assets/performance_page_env_only.png)

Click the **Save** button.

Finally, update the two Docker widgets. They don't use template variables by default, so in this case you will add `$env` to the **from** field under **Graph your data**:

![Adding env to the Docker widget queries](./assets/add_env_to_docker_widget_queries.png)

Note that if you want to add an environment variable to many widgets at the same time, there is a handy **Add to All** option on the far right of the template variable configuration editor.

![Add var to all widgets](./assets/add_var_to_all.png)

Click the **Save** button.

Now all of the widgets can easily display metrics from the specific environment selected at the top of the dashboard.

### Global Time
Another issue in this dashboard is that the Docker widgets will show metrics from the past hour, regardless of the time period you select in the global time selector: ![Docker widgets always show the past hour](./assets/widgets_stuck_at_1h.png)

There are situations where this may be desirable, but the CEO wants all of the widgets to display data from the same time period. To achieve this, for each of the Docker widgets:

1. Click the **pencil** icon to edit the widget
1. Under **Set display preferences**, click on the **Show:** select menu and change **Past 1 Hour** to **Global Time** ![Change 1 hour to Global Time](./assets/set_docker_widgets_to_global_time.png)
1. Click the **Save** button.

Now when you select a time frame in the global time selector, all of the widgets will display data from that time period.

You have copied all of the useful preset widgets for the executive dashboard and synchronized them to the same environment and time period. You can now move on to creating the custom widgets. Click the **Continue** button below to create a custom revenue metric and widget.