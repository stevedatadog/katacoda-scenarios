To understand what `discounts-service` provides, you can make an HTTP GET request to it using `curl` in the terminal: `curl http://localhost:5001/discount`{{execute}}. Alternatively, you can also click on the **Discounts API** tab above the terminal to see the results in your browser. Either way, the response will be a JSON document containing 206 discounts that look like this this:

```json
  {
    "code": "VIBRANT", 
    "discount_type": {
      "discount_query": "price * 0.660373", 
      "id": 2, 
      "name": "hello"
    }, 
    "id": 2, 
    "name": "symptom sibling omit", 
    "value": 7
  }
```
The store-frontend service picks a random discount from the response and creates a coupon section in the upper-left corner of the Storedog homepage. 

![Coupon section detail of Storedog homepage](./assets/coupon_section_detail.png)

You can see that `name` maps to the title of the coupon section of the home page. `code` can be found in the instructions below the title, followed by `value` formatted to the dollar value "$7.00."

Now that you know what a healthy discounts-service should serve, you can create an API test to monitor it and ensure that it continues to function properly across deployments. 

Log in to the Datadog app using the credentials created for you. (Run the `creds`{{execute}} command if you don't have them handy.) Navigate to **Synthetic Tests** in the global navigation, under **UX Monitoring**. You will see the Get started with Datadog Synthetics introduction page. Click the **Get Started** button and then the **New API Test** button in the resulting modal dialog.

You will create a new HTTP test, which is selected by default. Note that API tests can also monitor SSL, TCP, and DNS services. You can read more about those in the [API Tests documentation](https://docs.datadoghq.com/synthetics/api_tests/).

In the **Define request** section, enter your discount service URL, which is `https://[[HOST_SUBDOMAIN]]-5001-[[KATACODA_HOST]].environments.katacoda.com/`{{copy}} 

**@todo** *determine whether to reveal the Advanced options here, or in the multistep api test...*

Enter a value for **Name**, such as "Discounts API Test."

Choose one or more **Locations** from which to run the test.

Click the **Test URL** button to ensure that the URL is correct and yields the expected response. The **Response Preview** section on the right hand side of the page displays a lot of information about the request and response. Under **BODY**, you should see the JSON document containing 206 discount codes.