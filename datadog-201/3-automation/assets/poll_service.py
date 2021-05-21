import os
import time
from datadog import initialize, api

initialize()

tag_env=os.getenv['DD_ENV']
tag_service=os.getenv['DD_SERVICE']
tag_host=os.uname()[1]
query_metric=os.getenv['DD_QUERY_METRIC']
event_title='{service} is up'.format(service=tag_service)
event_text='The service polling script detected {metric} from {environment} on {host}'.format(
    metric=query_metric, env=tag_env, service=tag_service
)
tags=[tag_env, tag_service]

api.Event.create(event_title, event_text, tags=tags)

query_end_time=int(start=time.time())
query_start_time=query_end_time - 120
query_redis_cpu='avg:redis.cpu.sys{{{env},{service}}}'.format(env=tag_env, service=tag_service)
api.Metric.query(start=query_start_time, end=query_end_time, query=query_redis_cpu)