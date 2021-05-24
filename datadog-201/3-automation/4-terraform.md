If you have only a small cloud footprint, rarely provision new services, or you’re a one-person team, interacting with our API from ad hoc scripts and shell one-liners may be as much automation as you need. If you’re a growing team without a well-established workflow, or your scale has outgrown your existing tooling, an infrastructure-as-code (IaC) tool is worth looking into.

Terraform is a popular IaC tool for managing infrastructure across many providers, on and off the cloud. The Datadog provider for Terraform allows you to provision monitors and dashboards at the same time that you provision your system.

Load `lab/terraform/datadog.tf`{{open}} in the IDE to see how customer monitors and a dashboard can be defined in a Terraform configuration file.


There is a terraform file that provisions a small web application called Stately. It consists of a falcon web server and a redis session cache. 

`terraform init`{{execute}}

`terraform apply --auto-approve`{{execute}}

Take a look at the Datadog app to see the monitor and dashboard created.

**todo** flesh out the above and explain:
  - key aspects of terraform configuration files
  - value of datadog monitors, dashboards as IaC