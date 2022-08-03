---
created: 2022-10-04T22:57:06+02:00
lastmod: 2022-12-04T17:08:50+01:00
title: 12 Factor Apps
tags: []
aliases: []
---
> An app’s _config_ is everything that is likely to vary between [deploys](https://12factor.net/codebase)

> A [deploy](https://12factor.net/codebase) of the twelve-factor app should be able to swap out a local MySQL database with one managed by a third party (such as [Amazon RDS](http://aws.amazon.com/rds/)) without any changes to the app’s code...  only the resource handle in the config needs to change.

# V. Build, release, run
A [codebase](https://12factor.net/codebase) is transformed into a (non-development) deploy through three stages:
- The _build stage_ is a transform which converts a code repo into an executable bundle known as a _build_. Using a version of the code at a commit specified by the deployment process, the build stage fetches vendors [dependencies](https://12factor.net/dependencies) and compiles binaries and assets.
- **The release stage takes the build produced by the build stage and combines it with the deploy’s current config.** The resulting _release_ contains both the build and the config and is ready for immediate execution in the execution environment.
- The _run stage_ (also known as “runtime”) runs the app in the execution environment, by launching some set of the app’s [processes](https://12factor.net/processes) against a selected release.

![[assets/12_factor_app_schema.png]]

> Every release should always have a unique release ID, such as a timestamp of the release (such as `2011-04-06-20:32:17`) or an incrementing number (such as `v100`). Releases are an append-only ledger and a release cannot be mutated once it is created. Any change must create a new release.

> The twelve-factor app never assumes that anything cached in memory or on disk will be available on a future request or job

- use the same type and version of backing service in development and production (all instances of deployment) - e.g. do not use sqlite in dev and postgresql in prod, even though they have the same interface (=ORM in this case)
- use docker
