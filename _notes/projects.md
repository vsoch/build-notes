---
title: Projects
categories: projects
tags: [projects]
maths: 1
toc: 1
---

{% include toc.html %}

## Projects

The following are mini-projects that I'd like to try:

### ABI compatability

If ABI compatability comes down to mangled strings (e.g., {% cite winters:ewg20-what-is-abi %}{% cite winters:ewg20-now-or-never %}) then I'd want to:

1. Figure out how to parse a binary to collect all "mangled strings"
2. Build a container that can install a library across multiple versions
3. Inspect how the strings change (if at all)
4. Perhaps create a tool that can easily do this.

I think this would be a start to figuring out ABI compatability, because we could
then easily parse two things and calculate some similarity score between them based on
the strings! I don't know if this is the right way to go about it, but it seems like it would
be fun to do.


<hr>

{% bibliography --cited %}
