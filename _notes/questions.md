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

### Are more constraints better?

{% cite abate2012dependency %} mentioned that it gets more complex as the size of the repository increases and you add more metadata, but it seems like being able to eliminate solutions more quickly that don't fit with some architecture would get us faster to a solution (or a no solution). So is the trick having fewer metadata points that are more useful (e.g., something derived from the package binaries is more meaningful than random user specifications of versions needed?)

{% bibliography --cited %}
