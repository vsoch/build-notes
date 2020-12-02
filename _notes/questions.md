---
title: Questions
categories: questions
tags: [questions]
maths: 1
toc: 1
---

{% include toc.html %}

## Questions

### Are there alternatives to package managers?

If a lot of the complexity comes down to the upgrade problem (needing to install a new package given an existing set, and then upgrade some subset of that) we could arguably just maintain one container per package, each with the exact dependencies needed by that package.
This means that when we want a new package version, we throw away the old container and build/get a new one.

I'm not saying this is a good solution (it's very redundant) but it's inspiring for thought!


{% bibliography --cited %}
