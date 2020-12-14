---
toc: 1
---

# Dependency Versioning in the Wild

## Overview

This paper {% cite dietrich+:msr19 %} is a nice little study to look at how developers specify versions in the 
wild. They state their four main questions to answer as:

1. How do projects declare dependencies?
2. Do projects change their approach as they evolve?
3. How do projects adapt semantic versioning?

### Details

They basically started with packages on [libraries.io](https://libraries.io/) (several millions) and then
from the dependency files (e.g., requirements.txt, pom.xml, etc.) created several regular expressions to match
different ways to specify versions.  For example, "at least" might have a regular expression to match 
`1.2.3,*`, and the rest of the classifications are shown in Table 1, below:

![{{ site.baseurl }}/assets/img/notes/dietrich-mrs19-table-1.png]({{ site.baseurl }}/assets/img/notes/dietrich-mrs19-table-1.png)

And then aggregated classifications futher, e.g.,

 - SEMVER: matching var-micro or var-minor
 - FLEXIBLE: matching range or soft or any or latest or not or at-least or at-most
 - FIXED: matching fixed
 - OTHER: matching other or unresolved or unclassified

Unresolved means that you reached the end of the list of regular expressions and didn't find a match.
They also gave developers a survey asking about how they used semantic versioning (or not)
and how they generally declared dependencies.

And they discovered the following:

1. Most use some flexible version syntax, and others use semver most predominantly. Maven is an outlier because they think developers probably just copy paste the dependencies from the package websites.
2. Projects get more dependencies as they are developed, with the exception of homebrew. Developers suggest that they move away from a flexible approach to hard code versions because of experiences with bad bugs not doing so (reproducibility!).
3. Most package managers encourage it, only a few require it. It's checked only superficially.

This makes me want to do a similar project to find a scoped set of packages in a particular package manager,
and then access the degree of changes per version jump (e.g., lines changed, packages added or removed, etc.).

<hr>

{% bibliography --cited %}
