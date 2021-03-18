Introduction
===
Synthetic tests allow you to observe how your systems and applications are performing using simulated requests and actions from around the globe. Datadog tracks the performance of your webpages and APIs from the backend to the frontend, and at various network levels (HTTP, TCP, SSL, and DNS) in a controlled and stable way. Synthetic monitoring will alert you in case of faulty behavior such as a regression, broken feature, high response time, unexpected status code, and more. 

Synthetic tests enable you to monitor your applications and services proactively; Datadog will alert you to problems before your users do. This will give your team the confidence to release early and often without worrying too much about the damage of regressions. Once you have Synthetic Monitoring up and running, you can incorporate its metrics into [Service Level Objectives](https://docs.datadoghq.com/monitors/service_level_objectives/) (SLOs) to define and track performance targets.

There are three types of synthetic tests: API tests, multistep API tests, and browser Tests. 

API Tests
---
API tests are useful to help you proactively monitor that your most important services are available at anytime and from anywhere. There are four types of API tests that allow you to launch requests on the different network layers of your systems, and evaluate the values of their responses:

| test type | response values |
| ---       | ---             |
| HTTP      | response time, status code, body properties, header properties |
| SSL       | response time, time to certificate expiration, property values, TLS version |
| TCP       | response time |
| DNS       | response time, record values |

Each test's request can be configured as appropriate for the type. For example, HTTP tests allow you to configure many common HTTP request attributes such as the header, cookies, body, and more. DNS tests allow you to configure lookups to use a specific DNS server.

![Animated screencap of creating and running an API test](api-test.gif)

Multistep API Tests
---
Multistep API tests allow you to chain multiple HTTP API requests in a single test. They are suitable for monitoring sophisticated business transactions, where the response from one service request can be used in another. For example, to get an authentication token prior to making further requests to protected API endpoints, or to model complex mobile app journeys across your API endpoints.

![Animated screencap of creating and running a multistep API test](multistep-api-test.gif)

As with HTTP API tests, you can configure many HTTP request attributes and evaluate many response values.

Browser Tests
---
Browser tests make requests using a browser, just like humans do. You can record a user flow through your web application, and evaluate almost anything in the resulting Document Object Model (DOM) of the page. For example, when you open your web application's home page, is the title correct? When you add a product to the shopping cart, is the price correct? Did the HTTP response arrive in under 300ms?

Datadog's browser tests don't have to be reconfigured every time your application's DOM changes. For instance, when a button in your web app is moved or the identifier of an element changes, a browser test infers how to carry out the existing test in the updated UI.
 
Like API tests, you can configure many HTTP request attributes. Additionally, you can configure the screen dimensions of the device making the requests (laptop, tablet, mobile), as well as the browser to use (Chrome, Firefox).

![Animated screencap of creating and running a browser test](browser-test.gif)

Like Multistep API tests, you can chain many user actions and assertions together in a single test. Browser tests will generate a screenshot for every assertion, so you can see exactly what your users would see. Furthermore, Datadog synthetic browser tests are tightly integrated with the rest of the platform, so you have access to end-to-end context for troubleshooting, from application logs and distributed request traces to infrastructure metrics.

Test Locations
---
All of the Datadog synthetic test types allow you to choose which geographical regions to run them from. This is useful to see what the experience is like for users from around the globe. 

Monitoring and Alerts
---
All of the synthetic tests can be configured to run at intervals from 5 minutes to 1 week. You can configure the alerting conditions based on failure rate and response time. Alert [notifications](https://docs.datadoghq.com/monitors/notifications/?tab=is_alert) can be configured in the same way as any other Datadog monitor alert.

Now that you're familiar with the different types of Datadog synthetic tests, it's time to lean how to create them in a hands-on lab. Click the **Next** button to begin.