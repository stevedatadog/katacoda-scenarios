The Datadog provider for Terraform allows you to provision monitors and dashboards at the same time that you provision your system.

There is a terraform file that provisions a small web application called Stately. It consists of a falcon web server and a redis session cache. 

`terraform init`

`terraform apply --auto-approve`

Take a look at the Datadog app to see the monitor and dashboard created.