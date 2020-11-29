---
toc: 1
---

## Using Preferences to Tame your Package Manager

### Overview

This paper appears to be for a talk, and starts by explaining why we need package managers, 
primarily because considering all combinations (e.g., of versions) is NP-complete. It then 
introduces the idea of using **solvers** that can honor user preferences to come up with a solution, 
and how it should be possible to honor user preferences. E.g.:

 - "I want to minimize the number of packages I need to upgrade."

and specifically highlights the [opam](https://opam.ocaml.org/about.html) package manager, 
which uses [CUDF](https://www.mancoosi.org/cudf/) pivot format to represent these user preferences. 
An interesting idea is that the solver is modular, but doesn't necessarily need to be alongside the software. They highlight
making an external "solver farm" available (in the cloud) at their institution (Iril) for this purpose.

### Takeaways

This talk might have introduced a novel idea of not just using modular solvers, but having them
be based in the cloud so an entire community can use them from anywhere.
The authors also seem to be suggesting that it's best practice to use some kind of standard that also allows
for user preferences (the one developed by the Mancoosi project) and then coming up with a solution (in CUDF format) that comes down to a list of changes to make on the system.

### Terms

 - [OCaml](https://ocaml.org/learn/description.html) is a programming language developed at Inria.
 - [OPAM](https://opam.ocaml.org/about.html) is a package manager for OCaml
 

#### Mancoosi Project

The [Mancoosi project](https://www.mancoosi.org/) was created to generally develop FOSS tools
for sysadmins (e.g., package managers, and standards). This paper is concerned with it's preference
language, which describes using **package selectors** and **measurement functions** to control
how dependency resolution is done by the manager.

##### Package Selectors

These identify a set of packages, e.g., solution, new, removed, changed, up, and down. For example,
"changed" would be the set of packages that were changed in some proposed solution, S.

##### Measurements

An integer valued function that can be applied to any package selector, plus additional arguments. For
example, I could do `count(X)` to count the number of entries in some set X. You should reference the second
page of the PDF to see all the different measurement functions.

#### CUDF

[CUDF](https://www.mancoosi.org/cudf/) means "Common Upgradeable Description Format" and it comes
down to being a text file that describes how user preferences map into update actions. Specifically:

{% quote abate+:ocaml14-pkg-manager-prefs %}
A format to encode upgrade problems which is recognized by several specialised dependency solvers, and allows users to express complex scenarios in awell defined and compact way by means of preferences that are passed over to the external solver.
{% endquote %}

There is a nice primer [here](https://www.mancoosi.org/cudf/primer/). But TLDR, it looks like a flattened yaml file with a list of packages, conflicts, and other metadata.

```yaml
package: m4
version: 3
depends: libc6 >= 8

package: openssl
version: 11
depends: libc6 >= 18, libssl0.9.8 >= 8, zlib1g >= 1
conflicts: ssleay < 1
```

