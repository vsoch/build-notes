---
title: Package Manager Flow
maths: 1
toc: 1
---

{% include toc.html %}

## Overview

We should eventually be able to describe the makeup of a package manager - akin to how the
Open Containers Initiative has an image-spec, distribution-spec, and runtime-spec for containers,
we want similar specs to describe actions and states for package management. I don't have a holistic view yet
of what this should look like, but I'll include interesting notes that are relevant.
Here is an early understanding of a general flow:

```
user preferences --> package manager --> solver --> scenario --> [if solution] --> action
                                                                 [else]        --> rollback
```
The above says that we start with user preferences that are assembled by the package manager client,
at some point generate a CUDF document that describes the needed changes, hand them off to a solver to come up
with a solution. There are several ways to describe a solution (scenario) that determines
if we move forward or not. There are also terms that can describe the scenarios [terms](#terms)

## User preferences

The user should be able to specify high level criteria to describe what they want (e.g., minimize changed packages).
Of course the more criteria we define, the more likely we are to not be able to find a solution or
have something pareto-optimal. Approaches to deal with this include:

 - **Lexicographic**: order criteria by importance (e.g., a security update gets ranked higher)
 - **Weighted sum**: aggregate criteria into single measure using some set of weights
 - **lexmin and lexmax**: (haven't read about yet)

The authors in {% cite abate-2013-modular-package-manager --locator 14 %} propose to do the following:

1. define a dictionary of criteria
2. define a dictionary of aggregation functions (e.g., the above)
3. write the user preference as an expression of the aggregation function (op) and directionality (e.g., +/-) for each criteria. E.g.,

```
lex(-removed, -changed)
```

Says use lexmin to aggregate, and minimize changed and removed packages. They present a nice table of
optimization criteria:

<img src="{{ site.baseurl }}/assets/img/notes/table-1-optimization-criteria-abate-2013.png">

And this is a neat idea because you can then describe specific scenarios (and name them)

```
paranoid=lex(−removed,−changed)
trendy=lex(−removed,−notuptodate,−unsatrec,−new)
```

## Scenarios

The paper {% cite abate-2013-modular-package-manager --locator 12 %} describes different solution scenarios,
rooted in CUDF, and this would be a good terminology to harden to better describe our work.

We start with a {% include term.html key='cudf' title="CUDF document" %} and define a solution to it 
as a subset (`S`) of the entire package universe (`U`). We then say that `dom(S)` (domain) are the pairs
of packages (e.g., `(name, version)` in our subset (e.g., what CUDF is asking for) in  `S`, and `pro(S)` (provided)
the same `(name, version)` pairs of all that are available, which can be infinite (gulp!).

This defines an atomic package constraint. A subset `S` in `U` is (these are written verbatim from the paper):

 - **abundant** if every disjunction in the dependency of every package in `S` contains a package constraint that is satisfied by `dom(S) ∪ pro(S)`. I think this is saying that a solution is abundant if every nested dependency has it's own dependency needs met by either the set of pairs that we need, or the set of pairs available to us. It's abundant possibly because it says that the universe is rich with everything that we need.
 - **peaceful** if no atomic package constraint in the conflicts of any package `p∈S` is satisfied by `dom(S−{p}) ∪ pro(S−{p}`). I think this is saying that if we removed p from both sets, there would be no conflict.

## Requests

A subest `S` of the universe `U` satisfies a request:

 - **install** φ if every atomic constraint in φ is satisfied by `dom(S) ∪ pro(S)`. This is saying we move forward to install if the universe is abundant?)
 - **remove** φ if no element of φ is satisfied by `dom(S) ∪ pro(S)`.

A set `S` is only a solution if it is abundant, healthy, and satisfies the request.
Solutions are allowed to have several packages with the same name and different versions.

## Terms

We can further classify solutions based on:

 - **correctness**: have we satisfied the user request?
 - **quality**: do I like the solution?


## Solvers

It looks like there are many solver technologies, as references by {% cite abate-2013-modular-package-manager %} in the MISC competition (Mancoosi International Solver Competition [ref](https://www.mancoosi.org/misc/)) including but not limited to:

 - boolean satisfiability (SAT)
 - Mixed Integer Linear Programming (MILP)
 - Answer Set Programming (ASP)
 - graph constraints

And I think we intend to work on one based on ABI compatability. Many of these can handle upgrade problems encoded as CUDF documents.
<hr>

{% bibliography --cited %}
