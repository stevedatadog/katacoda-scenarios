CI/CD is shorthand for continuous integration and continuous delivery (or deployment).

- **"Continuous integration"** is the practice of incorporating code changes into your software's main codebase as quickly, frequently, and safely as possible. 
- **"Continuous delivery"** is the practice of automatically building production-ready software artifacts whenever the codebase is updated. 
- **"Continuous deployment"** takes continuous delivery one step further, automatically shipping your freshly-built software artifacts to their ultimate destinations as soon as it's built.

There is a multitude of automated tools that store, analyze, clean, test, build, and ship code. They are typically chained together, the output of one tool producing the input to the next. This entire system is called a "pipeline," and each organization's pipeline will be unique. Yet they all share the same goal: to update software code on one end, and enjoy an automated, bug-free software deployment on the other.

While there are infinite combinations of software, tools, and workflows that could comprise a CI/CD pipeline, a typical pipeline consists of these four stages:

1. Source: Developers commit changes to codebase
2. Build: Codebase is built into software
3. Staging: Software is deployed privately and tested
4. Production: Software is deployed publicly 

Any amount of testing and analysis can be performed in a CI/CD pipeline. A developer might run unit tests as they alter source code. The build process might perform integration tests to ensure that systems will continue to work correctly as new code is built. Humans might perform user acceptance testing when the software is deployed to the staging environment, as well as when it is released to the public.

With Synthetic tests, Datadog makes it easy to automate this testing at every stage of your CI/CD pipeline. Datadog provides an API and a dedicated CLI to trigger API and end-to-end tests on demand and inform your pipeline of the results. You can automatically halt a build, prohibit a deployment, or even roll back a deployment when one of your Synthetic tests detects a regression.

Continuously testing your applications allows you to create a safety net for your code changes: you will maintain your end users' experience on your application and improve your team's confidence about releases.

Click the **Next** button below to learn about the CI/CD pipeline you're going to work with.