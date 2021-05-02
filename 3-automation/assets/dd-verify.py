import time
from datadog import initialize, api

initialize()

start_event_title="Redis Session Cache Verification"
start_event_text="Beginning verification process"
tag_env="env:dd201"
tag_service="service:redis-session-cache"
event_tags=[tag_env, tag_service]
api.Event.create(start_event_title, start_event_text, tags=event_tags)

query_start_time=start=int(time.time()) - 3600
query_end_time=int(start=time.time())
query_redis_cpu='avg:redis.cpu.sys{{{env},{service}}}'.format(tag_env, tag_service)

api.Metric.query(start=query_start_time, end=query_end_time,
                     query=redis_cpu)