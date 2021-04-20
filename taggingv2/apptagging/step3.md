Tags can also act as Facets for various lists throughout Datadog. Let's create two synthetic tests for the Storedog home page to understand tags as facets.  

1. In Datadog, navigate to <a href="https://app.datadoghq.com/synthetics/list" target="_datadog">**UX Monitoring** > **Synthetic Tests**</a>.

2. Click **Get Started** in the top right, and select **New API Test**. 

3. For **Choose Request Type**, select **HTTP**.

4. Under **Define request**, fill in each field as shown below. 

    **Note**: For **URL**, enter the custom URL for your Storedog home page: `https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com/`{{copy}} 

    ![syn-makerequest](apptagging/assets/syn-makerequest2.png)

5. Expand **Define assertions**. Click **New Assertion** and fill in the fields as follows: **When `response time` `is less than` `10`ms**.

6. Expand **Specify test frequency** and select **1w**.

5. Expand **Define alert conditions** and fill in each field as follows: **An alert is triggered if your test fails for `1` minutes from any `1` of 5 locations. Retry  `1` time before location is marked as failed**.

6. Expand **Notify your team** the section. You can leave this section blank, or you can enter a message and select to receive notifications.

7. Click **Create Test**. You will be redirected to the new Synthethic test. 

    You will see a message near the top that you may need to refresh the page after a moment once data starts coming in. This is expected. 

    Under **Properties**, notice the two tags you assigned to the test.

8. Above the test name, click **Synthetics** to navigate to the test list.

9. On the left, expand the **TAGS** facet. You will see menus for **service** and **team**, which were created because you assigned the tag to the synthetic test.

10. In the search field above the list of facets, enter `tag:service:store-frontend`{{copy}}. You will see that you can still see the test you created in the list.

11. Click **New Test** in the upper right and follow steps 2 - 7 above with the following changes. In **Define request**, name the new test `Test on Storedog Home Page 2` and do **not** assign the `service:store-frontend` tag.

12. Navigate to the Synthetics list and view the **ENV** and **TAGS** facet. 

    Notice that there are 2 tests for `env:ruby-shop` and `team:frontend`, but only 1 test for `service:store-frontend`.

13. In the search field above the list of facets, enter `tag:service:store-frontend`{{copy}}. Only the `Test on Storedog Home Page` test appears in the list.

    Assigning relevant tags ensures that you can find all tests associated with each tag and connects your tests to related data throughout Datadog.

14. Navigate to <a href="https://app.datadoghq.com/apm/services" target="_datadog">**APM** > **Services**</a>. Select **store-frontend**.

15. Click the Monitor banner above the graphs. All monitors (including budget alerts on SLOs) and synthetic tests that have the `env:ruby-shop` and `service:store-frontend` tags are listed in the panel that opens.

    In general, all monitor or synthetic tests that have tags for a specific `env` and `service` will be linked to the corresponding APM Service page. Similarly, all monitors and synthetic tests that have tags for a specific `env`, `service`, and `resource_name` will be linked to the corresponding APM Service and Resource pages.

    Notice only the first synthetic test you created is listed under **Synthetics Tests** because it was assigned the `service:store-frontend` tag.

16. Navigate to the <a href="https://app.datadoghq.com/synthetics/list" target="_datadog">**UX Monitoring** > **Synthetic Tests**</a>. Select the tests you created and delete the tests. (This is to avoid unnecessary pings to the lab environment after you complete the lab.)
