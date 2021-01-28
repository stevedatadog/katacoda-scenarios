You're confident that the API test you created will alert you when the discounts service is down, slow to respond, or returning something other than well-formed JSON objects from the GET /discounts endpoint. But there's also a POST /discounts endpoint for creating new discounts. And a DELETE /discounts endpoint, too! You should make sure that these functions will be monitored for deployment regressions, too. Fortunately, a synthetic mutistep API test can cover both of them.

## About the POST and DELETE Endpoints
When a discounts service receives a POST request, it automatically creates a random discount and adds it to the database. The response will be a JSON document containing the newly created discount. For example,

```json
{
    "code" : '',
    "id": 207,
    "foo": '',
    "bar": {"baz" : "quux"}
}
```