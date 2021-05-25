If you have only a small cloud footprint, rarely provision new services, or you’re a one-person team, interacting with our API from ad hoc scripts and shell one-liners may be as much automation as you need. If you’re a growing team without a well-established workflow, or your scale has outgrown your existing tooling, an infrastructure-as-code (IaC) tool is worth looking into.

Terraform is a popular IaC tool for managing infrastructure across many providers, on and off the cloud. The Datadog provider for Terraform allows you to provision monitors and dashboards at the same time that you provision your system.

## Shut down Stately!
Before continuing, shut down the Stately! application that is running under docker-compose: `cd /root/lab/ && docker-compose stop`{{execute}} You're going to start up a new instance of the application using Terraform.
## Terraform configuration
There are three Terraform files that provision this application. Open the IDE and look at each of these files:

`variables.tf` brings your API and Application keys into scope from the environment. 
`main.tf` defines and configures the Datadog agent, Redis service, and Python application Docker containers. It's similar to the `docker-compose.yml` file that you used earlier in the lab. All of the Datadog container labels and environment variables are configured here.
`datadog.tf` creates a Datadog monitor and a dashboard for the application.

These files could have been combined into a single file, or even broken down into even more files. Terraform will slurp up all the `.tf` files in the current directory and figure out what to do.

Take a look at `datadog.tf`{{open}} in the IDE. This file defines two resources: 
  - A `datadog_monitor` that watches `redis.cpu.sys`
  - A dashboard containing 5 widgets

The `datadog_monitor` resource configuration closely matches the **Monitors > New Monitor** configuration in the Datadog app.

Each of the widget blocks follows the [Datadog API schema](https://docs.datadoghq.com/dashboards/widgets/) for its type. Each is accompanied by a `widget_layout` block defining its place on the dashboard.

Take a closer look at the `alert_graph` widget in the `datadog_dashboard` resource configuration. The `alert_id` value is `${datadog_monitor.redis_cpu.id}`, which references the id of the `datadog_monitor`. This the id will become available after Terraform creates it, and the dashboard will be able to display it as an alert graph.

## Run Terraform
First, run `terraform init`{{execute}} so Terraform can download the Docker and Datadog providers declared at the top of `main.tf`.

Next, run `terraform apply --auto-approve`{{execute}} to get Stately! and the Datadog dashboard up and running. You should see 

Take a look at the Datadog app to see the monitor and dashboard created.

**todo** flesh out the above and explain:
  - key aspects of terraform configuration files
  - value of datadog monitors, dashboards as IaC