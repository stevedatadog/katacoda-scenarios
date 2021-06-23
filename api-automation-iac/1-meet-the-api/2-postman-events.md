## Authentication
Requests to the Datadog API require authorization headers containing a API key and often an application key. Click on the **Authorization** tab in the request builder:

![Postman authorization tab](./assets/postman_auth_tab.png) 

**TODO**
- Explain how the Datadog environment works
- Walk learner through setting their API and APP keys
- Make first request with postman by pasting this into the body:
    ```
    {
      "title": "New Event",
      "text": "This event came from Postman!",
      "tags": [
        "env:api-course"
      ]
    }
    ```
 - Do the same to query for events and find the posted event in the response, using only `start` and `end` params

Click the **Continue** button to 




