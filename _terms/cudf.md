---
terms: 1
---

## CUDF

[CUDF](https://www.mancoosi.org/cudf/) means "Common Upgradeable Description Format" and it comes
down to being a text file that describes how user preferences map into update actions. I tend to think of it as
an upgrade problem encoded in a text file, or the input/output format for package managers (such as MPM)
to represent an upgrade scenario. The paper {% cite abate2020dependency %} calls CUDF:

{% quote abate2020dependency %}
a lingua franca between package managers and solvers
{% endquote %}

And in an earlier paper, the same authors defined CUDF as:

{% quote abate+:ocaml14-pkg-manager-prefs %}
A format to encode upgrade problems which is recognized by several specialised dependency solvers, and allows users to express complex scenarios in awell defined and compact way by means of preferences that are passed over to the external solver.
{% endquote %}

The paper {% cite abate-2013-modular-package-manager %} referes to it as a DSL (Domain Specific Language).
There is a nice primer [here](https://www.mancoosi.org/cudf/primer/). But TLDR, it looks like a flattened yaml file with a list of packages, conflicts, and other metadata.

```yaml
package: m4
version: 3
depends: libc6 >= 8

package: openssl
version: 11
depends: libc6 >= 18, libssl0.9.8 >= 8, zlib1g >= 1
conflicts: ssleay >= 1
```

### Principles of Design

#### Platform independence

CUDF is agnostic to component models, version schemas, how dependencies are specified, and the package manager.

#### Solver independence

CUDF should be able to function as input for many different kinds of solvers.

#### Readability

The text format (example above) is simple and easy to read.

#### Extensibility

CUDF represents core properties needed to perform some kind of update (see the text file above)
but if additional ones are wanted (e.g., package size, bugs) the authors mention that 
"custom properties" can be defined.

{% include tip.html content="If we do work on a solver, would we use CUDF and just add additional properties? E.g., ABI compatibility" %}

See the <a href="{{ site.baseurl }}/notes/containers#bootstrap-cudf">containers</a> idea section for this idea.

#### Formal Semantics

There seem to be a formal set of semantics to describe an upgrade scenario, specific to CUDF, including:

 - sections called the **preamble**, component **universe** and **request**
 - package
 - version
 - depends
 - conflicts
 - provides
 - installed
 - keep

Most of these are self explanatory! See page 10 of {% cite abate-2013-modular-package-manager --locator 10 %}
for full definitions.

### Expressiveness

CUDF sits between the package manager (a sort of client) and the dependency solvers, so it should
have adapters for different distributions (e.g., we already have Debian, RPM, Eclipse).

### Implementations and Tools

 - [libcudf](https://gforge.inria.fr/scm/?group_id=4385) is a reference implementation that has parsing and "pretty-printing" for CUDF. This means the tool can identify if a CUDF document satifies abundance and peace scenarios (see <a href="{{ site.baseurl }}/notes/flow">flow</a>) and if a solution is valid. There is also a `cudf-check` tool that provides the same.
 - [CUPT](https://wiki.debian.org/Cupt) is an apt-compatible package manager for debian that also use CUDF.
