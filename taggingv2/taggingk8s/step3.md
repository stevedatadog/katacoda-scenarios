<a href="https://docs.datadoghq.com/dashboards/" target="_blank">Dashboards</a> in Datadog allow you to visualize your infrastructure and application data in one place. You can use assigned tags to create widgets that focus on certain metrics or resources. Let's start creating a dashboard for the Kubernetes deployment.
 
1. In Datadog, navigate to <a href="https://app.datadoghq.com/dashboard/lists" target="_datadog">**Dashboards** > **Dashboard List**</a> and click **New Dashboard** in the top right.

2. Enter `Kubernetes Deployment`{{copy}} for the **Dashboard name** and select **New Timeboard**.

3. Let's graph the filesystem.usage for the community team in each environment. 

    In the dashboard area, click **Add graph**. Then, click and drag the **Timeseries** tile to the dashboard area.

    Fill the template as shown in the image below and then click **Save**. 

    Note: Below the first metric, click **Advanced**. Then, click **Add Query** two times to add two more metric fields. Under the metrics, change **Display** to `Area`.

    ![community-environment-timeseries](taggingk8s/assets/community-environment-timeseries.png)

4. In the new timeseries graph, click any of the data areas and view the options. 

    Say, you want to see which containers the data is related to. 

    Select **View related hosts**, and in the host map that opens, change **Hosts** to **Containers**. 

    You can see that the `environment` and `team` tags are already selected in **Filter by** because you used these tags to filter the data to create the timeseries graph. 
    
    Because of the tags, you can jump between the graph in the dashboard and the associated containers in the container map. 
    
5. Now, let's create a table that lists the kubernetes memory usage of any or all teams by color (an internal company designation). 
    
    First, you need to set up the <a href="https://docs.datadoghq.com/tagging/assigning_tags/?tab=agentv6#environment-variables" target="_datadog">template variable</a> that will allow you to select which team’s memory usage you want to view.

    In the dashboard you created, click **Add Template Variable** below the dashboard title. Then, click **Add Variable**. Enter `team` under **Name** and select `team` under **Tag or Attribute**. Click **Done**.

    Click and drag the **Table** tile to the dashboard area. 

    Fill the template as shown in the image below. Notice that `$team` is now available as an option in your filter by and group by lists. Click **Save**.

    ![teams-color-table](taggingk8s/assets/teams-color-table.png) 

6. At the top of the dashboard, select the different `$team` variable options and see the results for each team in the table you just created.

7. (Optional) Consider other metrics that you may want to visualize and track for this kubernetes deployment and continue adding other template variables and widgets to the dashboard using the different tags. 

8. Click the command `grademe`{{execute}} to receive credit for creating the dashboard. 

    Note: If you created the dashboard but received a grade of zero, make sure that the dashboard name is `Kubernetes Deployment`{{copy}}. To edit the name, click the down arrow next to the name, then click Edit. Enter the correct name and click Save. Click the `grademe` command above again.

9. In the upper right of the dashboard, click the wheel icon. Select **Delete dashboard** to remove the dashboard.