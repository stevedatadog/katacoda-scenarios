Let's interact with the app as a user and see what data shows up in Datadog.

1. To visit the StoreDog website, click on the **StoreDog** tab next to the terminal. It may take a few seconds to load.
2. Browse the site a bit like a real user might:
  1. Look at some products
  2. Search
  3. Add something to your cart
3. After a few seconds, you should start to see data populating in the [RUM Dashboard](https://app.datadoghq.com/rum/list)
4. If you click **Explorer** you'll get a more detailed view of the interactions.
5. Along the top of the graph, you can click and explore the types of data that RUM makes accessible to you:
  1. **Session** groups interactions by user session and includes information about session duration, pages visited, interactions, resources loaded, errors, etc. By clicking on a row here, you can also look at the attributes tab to determine the user IP, browser, and other information.
  2. **Views** shows you what pages users are visiting. Clicking on a row here provides more detail on the view including page load speeds and resources used.
  3. **User Action** lists actions taken by a user such as clicks and any custom actions you've defined with the [`addUserAction` API](https://docs.datadoghq.com/real_user_monitoring/browser/advanced_configuration/?tab=npm#custom-user-actions)
  4. **Errors** provides a list of errors experienced on the user side.
  5. **Resources** provides a list of all resources served to users.
  6. **Long Task** provides a listing of any task in a browser that blocks the main thread for more than 50ms.
6. Further information on the data that RUM collects is available [here](https://docs.datadoghq.com/real_user_monitoring/browser/data_collected/).