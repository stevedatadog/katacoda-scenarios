What is CI/CD?
===
CI/CD is shorthand for continuous integration and continuous delivery (or deployment). "Continuous integration" is the practice of incorporating code changes into your software's main codebase as quickly, frequently, and safely as possible. "Continuous delivery" is the practice of automatically building production-ready software artifacts whenever the codebase is updated. "Continuous deployment" takes continuous delivery one step further, automatically shipping your freshly-built software artifacts to their ultimate destinations as soon as it's built.

There is a multitude of automated tools that store, analyze, clean, test, build, and ship code. They are typically chained together, the output of one tool producing the input to the next. This entire system is called a "pipeline," and each organization's pipeline will be unique. Yet they all share the same goal: to update software code on one end, and enjoy an automated, bug-free software deployment on the other.

While there are infinite combinations of software, tools, and workflows that could comprise a CI/CD pipeline, most can be distilled to these four stages:

1. Source: Developers commit changes to codebase
2. Build: Codebase is built into software
3. Staging: Software is deployed privately and tested
4. Production: Software is deployed publicly 

Any amount of testing and analysis can be performed in a CI/CD pipeline. A developer might run unit tests as they alter source code. The build process might perform integration tests to ensure that systems will continue to work correctly as new code is built. Humans might perform user acceptance testing when the software is deployed to the staging environment, as well as when it is released to the public.

Datadog Synthetic tests can be run on-demand at any point in a CI/CD pipeline. Datadog provides an API that can trigger synthetic tests and inform your pipeline about the results. You can automatically halt a build or prohibit a deployment if a synthetic test fails. You can even roll back a deployment if a synthetic test fails.

Click the **Continue** button below to learn about the CI/CD pipeline you're going to work with.