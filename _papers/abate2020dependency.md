---
toc: 1
---

## Dependency Solving Is Still Hard,but We Are Getting Better at It

### TLDR

The main theme of the paper is to (in the author's words):

> treat dependency solving as a separate concern in package manager design and implementation, delegating it to a specialized, highly-capable dependency solver based on  state-of-the-art constraint solving and opti-mization techniques

Basically, dependency solving is (still) a hard (NP-complete) problem, and the authors take
issue that solver implementations should not have random, ad-hoc heuristics, and instead should use "tried and tested" techniques that can be plugged in to any package manager like plugins. This paper
thus reviews several of these solving techniques (SAT-solving, PBO, and MILP).
They think SAT solvers have the most promise. 

### Overview

#### What is a package manager responsible for?

This paper nicely describes the duties of a package manager:

1. Take as input:
  - the current status of packages on the system
  - a universe of all available packages (in other papers called `U`)
  - a user request (e.g., "install xyz, remove xyz")
  - user preferences (e.g., "minimize updated software")
2. Return as output:
  - an upgrade plan: a list of actions to take on the system to reach the status that the user wants (e.g., installing thething)

The user has expectations that, even without specifying preferences, they will
get the minimal set of packages needed to run the software that they want (imagine
trying to install something, it reports success, but then getting an error that a dependencyis missing!)

See the <a href="{{ site.baseurl }}/notes/flow#package-managers">package managers</a> section for how this fits into the overall flow. This paper also has a nice table of CUDF-friendly solvers from MISC 2010-11

![{{ site.baseurl }}/assets/img/notes/table-1-cudf-solvers-abate-2020.png]({{ site.baseurl }}/assets/img/notes/table-1-cudf-solvers-abate-2020.png)

This is an interesting approach if you make a standard - create a competition so others
use it!

#### How do we evaluate dependency solvers?

##### Expressivity

A good dependency solver is expressive in its metadata (e.g., allowing me to specify dependencies, conflicts, names, versions) and in it's client (e.g., I as a user can ask to optimize what I want in my upgrade plan, or maybe even my own criteria)! For BUILD, I'm wondering if we would be extracting binary metadata at runtime, or if it would be done in advance for some set of software (e.g., spack) and then we use it.

##### Complete

If there is a solution, the dependency solver finds it.

#### How can we summarize current solvers?

The authors came up with a list of criteria:

 - **versioning scheme**: How does the package manager specify versions? (e.g., semvar vs. git strings)
 - **distribution**: How are packages distributed? GitHub, message pigeons?
 - **granularity**: What minimal unit can be versioned?
 - **version locking**: Can developers lock the results of a resolution so itss reproducible?
 - **qualifiers**: Can we select specific dependencies based on some build config?
 - **dependency range operators**: This is what it sounds like - using <,>,= to specify versions acceptable
 - **range modifiers**: Allow developers to select ranges with terms like minor, etc.
 - **resolution process**: we evaluate based on correctness (are the solutions correct?), completeness (do we always find a solution if one exists?), and user preferences (can I give them?).
 - **approximae solutions** If a solution isn't found, can we relax constraints and find one anyway?
 - **missing dependencies**: If a dependency cannot be satisifed, do we exit and fail, or install the most up-to-date anyway?
 - **conflicts**: Do we bail with an error if the same package is needed in two versions, or install both of them?

And here is the table of results from the census, this is a great resource!

![{{ site.baseurl }}/assets/img/notes/table-2-cudf-solvers-abate-2020.png]({{ site.baseurl }}/assets/img/notes/table-2-cudf-solvers-abate-2020.png)

The authors are happy to report that, based on their cesus, they do see many
package managers using more modular, standardized solvers over ad-hoc approaches.
They note that only opam has embraced the "separation of concern" idea, and they think this
is because the CUDF format doesn't allow for overlapping versions and "dependency constaints involving qualifiers" (I'm not sure what an example of this is). Eg.., opam looks like this:

```bash
opam install merlin --criteria="-changed,-removed"
```
The social reason that the idea isn't more widespread is because a lot of major
tool communities would need to refactor to use a common standard, and one they don't control,
and it would be a lot of work.

> If it ain't broken, don't fix it!

I'd also like to point out that this paper got the quote from Field of Dreams incorrect! It's not:

>  If you build it, they will come

but actually:

> If you build it, he will come

How did the reviewers miss this ([ref](https://en.wikipedia.org/wiki/Field_of_Dreams#Plot))?
