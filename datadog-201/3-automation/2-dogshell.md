Dogshell is a command line client to the Datadog API. It comes with the Datadog for Python library.

To check if redis metrics are being collected:

`dog search query redis.cpu.sys`

Install the redis integration

`docker exec -it 7a2cfa agent integration install datadog-redis==3.0.0 -r`

