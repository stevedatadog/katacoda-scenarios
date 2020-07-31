## Exporting Graphs
We can also export individual graphs to this notebook. Go to the **Frontend Errors** graph and export it to the notebook we’ve created.  

Each graph can easily be unlinked from global time and set to a new time, manually or by dragging to select. Trying unlinking this graph from global time and changing the time range.  

You can also adjust the size of your graph.  

We can add some context to this graph for our teammates, or even add code snippets for applying a fix. Paste the below into your runbook, or add your own context.


<pre class="file" data-target="clipboard">
Typical behavior is to have most errors from `error.origin:network`- if other categories are spiking, should be investigated.  

## Solving Bottlenecks
By changing the line:
```
discounts = Discount.query.all()
```
To the following:
```
discounts = Discount.query.options(joinedload('*')).all()
```
We eager load the `discount_type` relation on the `discount`, and can grab all information without multiple trips to the database.
</pre>

## Custom Links
Going back to our cloned performance overview dashboard, we can link to our runbook directly from the **Frontend Errors** graph.  

Edit the **Frontend Errors** graph and click the **Custom Links** tab.

Copy in the URL of our notebook and give it a name, like `Sprees Runbook for {{$env.value}}`{{copy}}. This will populate the link name with our `env` template variable. Click **Done** and **Save**.  

Now, when we set `env` to `prod`, we can click on the **Frontend Errors** graph and see that our custom link has updated.  

## Shared Context
Now your dashboard and runbook link to each other. You can easily link to a runbook from a Monitor, a graph, or even an external team wiki. You can see notebooks you and teammates have created in the Notebooks list page.
