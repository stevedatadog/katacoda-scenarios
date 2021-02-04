You now have API tests to monitor the availability, performance, and functionality of the Storedog discounts service. For the rest of this course, you'll work with Browser Tests to monitor Storedog's frontend to ensure a good user experience. 

Earlier in this lab you saw how the Storedog frontend displays the response from the discounts service in the upper-left corner of the home page as a "coupon block":

![Coupon section detail of Storedog homepage](./assets/coupon_section_detail.png)

API tests make assertions about the raw content of HTTP responses, and browser tests make powerful assertions about the Document Object Model (DOM) as rendered by a browser.  For example, "This specific element is in the upper-left corner of the homepage," or "This heading is not empty and is displayed with the Helvetica font at 20 pixels."

The business requirements for the coupon block are:
1. It's displayed in the upper-left of the home page
2. It displays a non-empty heading
3. It contains a valid coupon code 
4. It contains the correct coupon value, formatted as USD currency

By the way, you may have noticed that the domain language for the discounts service is getting a little hazy. The Storedog frontend folks refer to discounts as "coupon codes," because that's how discounts are modeled for customers. This terminology inconsistency will give you something to troubleshoot in the second half of this course!

**Note:** *To create and edit browser tests, you must use Google Chrome and be able to install an extension from the Chrome Web Store. You may return to your preferred browser after you have created browser tests. The Datadog App will prompt you to install the extension.*

Now you can turn these frontend business requirements into a browser test.

## Create a Simple Browser Test
In the Datadog App, navigate to **UX Monitoring > New Test** and click on **New Browser Test**. Browser tests are configured in two parts. First, you configure the details common to synthetic tests. Then, you will record the specific actions the test should perform on the web application to satisfy assertions.

Before you proceed, create a new Global Variable for your lab's Storedog frontend URL. Follow the procedure you used to create `DISCOUNT_URL` in the previous step. Name the new Global Variable `FRONTEND_URL`, and give it the value `https://[[HOST_SUBDOMAIN]]-3000-[[KATACODA_HOST]].environments.katacoda.com/`{{copy}}.

### Test Details
1. For **Starting URL**, enter the global variable `{{ FRONTEND_URL }}`.
1. For **Name**, enter something like "Discount Rendered on Homepage".
1. Under **Browsers & Devices**, leave the defaults. These parameters are unique to browser tests and you should tailor them to suit your web application's typical visitor. Note that each selection will result in a separate test.
1. Under **Locations**, choose one or more regions from which to run the test. 
1. Under **Specify test frequency**, select **1w**, as you will run this test on demand in this course.
1. You can leave the defaults for **Define alert conditions** and **Notify your team**, as the notifications are the same as those from API tests.
1. Click **Save & Edit Recording** to move to the next step.

### Install the Test Recorder Extension
If you have already installed the Datadog Test Recorder extension, skip down to Edit the Browser Test. If not, you will see "Add our Chrome extension" and a **Add the Extension** button. 
1. Click the **Add the Extension** button to open the Chrome Web Store. 
1. On the **Datadog test recorder** page, click the **Add to Chrome** button.
1. Chrome will prompt you to confirm the installation. Click **Add extension**
1. You will see a dialog pop-up at the top of Chrome confirming that the extension is installed. It will say "Use this extension by clicking on this icon," but that is not necessary; the Datadog App will activate it when necessary.
1. Click Chrome's **Back** button to return to the Edit Browser Test page.

### Edit the Browser Test
If you have installed the Datadog Test Recorder extension, it will automatically make a request to the **Starting URL** you provided and display the results in the right-hand pane. You should see the Storedog homepage there now. You will now record a test to cover business requirement #1, "the coupon code block is displayed in the upper-left of the home page."

There is a tantalizing **Start Recording** button at the top of the left-hand pane. This is useful if the assertions you will make require user interaction to alter the page state, such as typing into a form or navigating to another page. You'll record interactions later.

1. Under **Add New**, click **Assertion**.
1. Click **Test that an element is present**. 
    ![Highlighting 'Test that an element is present' assertion](./assets/select_test_element_present.png)
1. Hover over the coupon block content, under the heading. It is the text that begins, "Enter the coupon code..." You will see a dashed outline surrounding the DOM element that Datadog detects. Move your cursor around to see what other elements Datadog detects.
1. Click on the coupon block content. You will see a new assertion appear on the left:
    ![Screenshot of first browser test assertion](./assets/first_browser_test_assertion.png)
1. Click on the new assertion. Note that you can update **Step Name** and configure **Advanced Options**. Leave the defaults and click **Cancel**.
1. This is a good start. Click **Save & Exit** to view the test details page.

Run this test manually to see the results:

1. Click **Run Test Now** in the upper-right corner of the test details page.
1. Scroll down to the **Test Results** section and click the **Refresh** button to see the results. You should see a result for every browser and device you configured. Click on one to view the test result details.
1. Click on the first result. You will see a result for each assertion in your browser test, with Step 0 always being "Navigate to start URL":
    ![Browser test assertion results](./assets/first_browser_test_results.png)
Each step created in a browser test will produce a result here. The result will have a screenshot of what Datadog saw when it executed the step, a summary of the step details, indicators for browser errors detected and resources downloaded, and a waterfall graph segment indicating when the step ran and how long it took.
1. Click on the **1 Error** indicator in Step 0. This will display a panel similar to a web browser's developer tools:
    ![The error tab of a browser test result](./assets/browser_test_error_panel.png)
Here you will see any errors, warnings, or messages that a web application logs to a browser's console. In Step 0, you can see the Console error, "Client Token is not configured, we will not send any data." You can ignore this.
1. Click on the **Resources** tab, or close the panel and click on the **Resources** indicator in the Step 0 results. This displays all of the resources that the browser downloaded to render the page:
    ![The browser test result Resources panel](./assets/browser_test_results_resources.png)
Here you can search resources, or filter them by toggling the types to the right of the search field.
1. Click on the **Traces** tab to see the Application Performance Monitoring (APM) traces collected during this step. You will see "No traces associated with this step." Datadog does not automatically associate APM traces with browser tests, and must be configured to do so:
    1. Navigate to **UX Monitoring > Settings** and click on the **Default Settings** tab.
    1. Under **APM integration for Browser Tests**, add this wildcard URL for Storedog running in your lab environment. The exact URL will change if your session expires, if you refresh your browser, or when you start the second part of this course. This wildcard should continue to work in all cases.
        ![APM integration for Storedog browser tests](./assets/apm_browser_test_integration.png)
    1. While you're here, note that you can also set **Default Locations** for future API and browser tests.
    1. Return to the browser test page and click **Run Test Now** to get results including APM traces.

    When APM traces for browser tests are configured, you will see a flame graph for all APM-enabled services that did some work in this step of the browser test:
    ![APM traces for Step 0 of this browser test](./assets/browser_test_results_traces.png)

    You can click the **View Trace in APM** link to dig deeper into the traces. See the Datadog Documentation to learn more about [APM traces in synthetic tests](https://docs.datadoghq.com/synthetics/apm).


