What is CI/CD?
===
CI/CD is shorthand for continuous integration and continuous delivery/deployment. "Continuous integration" is the practice of incorporating code changes into your software as quickly, frequently, and safely as possible. "Continuous delivery/deployment" is the practice of building and shipping your software artifacts to their ultimate destinations as quickly, frequently, and safely as possible. 

There is a multitude of automated tools that store, analyze, clean, test, build, and ship code. They are typically chained together, the output of one tool producing the input to the next. This entire system is called a "pipeline," and each organization's pipeline will be unique. They all share the dream: to commit code on one end, and enjoy an automated, bug-free deployment on the other.

There are infinite combinations of software, tools, and workflows that could comprise a CI/CD pipeline. But most can probably be distilled to these four stages:

1. Source: Developers commit changes
2. Build: Changes are built
3. Staging: Code is deployed privately and tested
4. Production: Code is deployed publicly 

A finer-grained pipeline might look like this:

1. Source
  1. Developer develops
  1. Developer runs local unit tests
  1. Developer commits to development repository
1. Build
  1. Build tool detects new commit
  1. Build tool checks out new code and builds development web app
  1. Build tool runs integration tests
  1. Build tool installs new web app code on staging server
1. Staging
  1. Build tool triggers automated UI and integration tests
  1. QA team runs manual and semi-automated UX tests 
  1. Build tool commits new code to production repository
1. Production
  1. Build tool detects new commit
  1. Build tool installs new code and builds production web app
  1. Build tool installs new web app code on production server
  1. Build tool triggers UI and integration tests
  1. Humans assess whether to roll-back deployment

No pipeline is perfect, especially when humans are involved. This is where Datadog synthetic tests come in. In addition to running on a regular schedule, synthetic tests can be run on-demand at any point in a CI/CD pipeline. Datadog provides an API that can inform your pipeline about synthetic tests results. You can automatically halt a build or prohibit a deployment if a synthetic test fails. You can even roll back a deployment if a synthetic test fails.
