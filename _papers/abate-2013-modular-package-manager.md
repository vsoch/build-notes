---
toc: 1
---

## A Modular Package Manager Architecture

### Overview

The authors present **package managers** the tools to install/remote software, and argue
that a modular architecture is ideal to allow for choosing backends and dependency solvers.
Installing packages is hard because:

 - you can't easily put them together, they are modular
 - you can't easily install more than one version of the same thing
 - they can change rapidly, and an initial install of several packages can break in the future (conflits)
 - you have to often install them on shared resources with different levels of permissions, etc.

Because installing packages is hard, we have package managers! Package managers generally:

 - they are the tools that the user interacts with (e.g., "apt-get install...)
 - can get and install packages from some remote resource (e.g., mirrors, cloudy places, GitHub)
 - they have some means to assess dependencies and create an update plan (e.g., that CUDF text file)
 - they execute the update plan, and fall back if things fail.

This can get complicated very quickly because of logical complexity (if you have a huge set of dependencies
and conflicts it's harder to find a solution) and scale (the more packages, the bigger the hairball to untangle).
Scale also takes into account the size of "the place you install packages from." The more you have,
the more resources that are needed for the remote, period.

The authors argue that the front end (the client interacting with the user) should be separate from the
back end (the dependency solver). They present their proof of concept, the Mancoosi Package Manager 
(MPM) that uses the Common Upgradeability Description Format (CUDF) and something called 
"the user preferences language" that helps do just that -
get preferences from the user.

#### The Upgrade Problem

You are usually okay when starting with a FOSS operating system, but as soon as a few packages
upgrade, you start running into dependency problems. This leads us to... **dependency hell!**

> the user gets entangled in an inextricable web of dependencies and conflicts that state-of-the-art package managers are unable  to handle.

And I love that this definition is included in the paper! They next walk through a dummy
example of how things break with python-simpy, showing the packages updated, installed, and removed for each 
(see {% cite abate-2013-modular-package-manager %}). They show how MPM is better because it gives the user
control to specify criteria. For example:

```bash
mpm -c "-removed,-changed" install python-simpy
```

Says to install python-simply and minimize removed and changed packages. The command is slow (~10 seconds)
and they justify this by saying it's just a proof of concept. This gives us a good idea for a framework to test package managers.

{% include tip.html content="We would want to be able to build contains across package managers (apt-get, yum, aptitude, etc.) and then simply install a particular package, and parse the terminal output to see the decision that was decided upon." %}

See the <a href="{{ site.baseurl }}/notes/containers#decision-comparison">containers</a> idea section for this idea.

#### Modular package management

The authors say that dependency solving is really hard, and it makes sense to de-couple it from
the rest of the package manager (the client to manage software components) so that they can be re-usable 
components. This brings back the idea of "solver farms," or externally hosted solvers. 
Figure 1 in their paper shows "modular package manager architecture" but I didn't find it very intuitive.

#### Scenarios

This is the first paper that I've encountered that describes different scenarios that package
managers can run into (e.g., healthy, peaceful). This is something that I think should be better flushed
out into an idea - "What is the standard or schema for some package manager flow?"
See the <a href="{{ site.baseurl }}/notes/flow">flow</a> page for this idea.

**stopped at end of page 15, will pick up later**

### Takeaways

The takeaway from this paper is that many package managers use ad-hoc heuristics, and this is messy.
If we uncouple dependency resolution from the package manager (e.g., the solvers) we can
more easily share components. The package manager should act as a skeleton client to interact with the
user, and we should be able to plug in components.

### Terms

 - **package** A software component paired with metadata that describes how to install it on a system. Each package can follow a unique development pipeline and even versioning scheme [reference](https://www.youtube.com/watch?v=NSemlYagjIU).
 - [CUDF](https://www.mancoosi.org/cudf/) The Common Upgradeability Description Format, a text file that describes all conflicts, and dependencies based on some user preferences to install software. See the {% include term.html key="cudf" %} term page for notes from this paper.
 - [user preference language]() "describes criteria used to determine the best solution"

#### Mancoosi Package Manager (MPM)

This is a proof of concept implementation of the idea of the authors, a modular package manager.
It uses CUDF to capture dependency information and the user preference langauage to ask the user
for what to optimize, etc. The implication is that the MPM is a creation of the [Mancoosi project](https://www.mancoosi.org/).
