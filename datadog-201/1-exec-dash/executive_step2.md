### Step 1 - Top level metrics… Continued


**Create your checkout uptime metrics**

Rather than focusing on the number of successful times people were able to checkout, we want to instead focus on the percentage of time the checkout was available.

We’re going to do this by creating a synthetics test

- Navigate to **Synthetics Tests** under UX Monitoring or click [this link](https://app.datadoghq.com/synthetics/list)
- Click **Get Started**
- Choose **New Browser Test**
- Fill out URL/domain - Paste in the URL of the Storedog site
- Fill in the name of your test - (This can be anything)
- Choose the locations you want your test to run - (This can be anything)
- Add the Chrome extension
- Click **Start Recording** and record your test
- Select **Save and Launch Test**

Now that we have created our test, we want to create a service level objective (SLO)

- Navigate to Monitors → **New SLO**
- Choose **Monitor Based**
- Select your synthetics test
- Choose your targets and message
- Click **Save & Exit**
- Navigate back to your dashboard
- Add the SLO Summary widget onto your dashboard
- Choose your newly created SLO
