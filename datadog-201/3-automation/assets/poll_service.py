import os
import time
from datadog import initialize, api

initialize()

""" Prepare context variables
"""
environment=os.getenv('DD_ENV')
host=os.uname()[1]
service=os.getenv('DD_SERVICE')

tags = [ 'env:{tag}'.format(tag=environment),
         'service:{tag}'.format(tag=service),
         'host:{tag}'.format(tag=host)
]

q_metric=os.getenv('DD_QUERY_METRIC')
query='avg:{metric}{{{tags}}}'.format(metric=q_metric, tags=','.join(tags))

""" Poll the API for metrics
"""
service_up=False
while not service_up:
    end_time=int(time.time())
    start_time=end_time - 120
    response=api.Metric.query(start=start_time, end=end_time, query=query)
    print(response)
    time.sleep(2)

""" Send event
"""
event_title='{service} is up'.format(service=service)
event_text='The service polling script detected {metric} from {env} on {host}'.format(
    metric=q_metric, env=environment, service=service
)
api.Event.create(event_title, event_text, tags=tags.append('source:python'))