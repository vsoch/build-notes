---
toc: 1
---

# Analyzing Dependencies in Large Component-Based Systems 

## Overview

The authors {% cite vieira+:ase02 %} introduce component-based systems as a good practice to develop software,
but say that enough work hasn't been done to understand dependency management.
The authors are suggesting an approach to model dependencies in... XML **scream**
(looks that paper is from 2002, phew) called CBDM, or the Component Based Dependence Model. 
I don't think this model took over, so this might be an example of what not to do.

### Component Based Systems

Or CBS is a collection od dependencies that rise from some original set of components.
Logically, tracking components gets harder as you install more things. This is the first
paper that recognizes two kinds of components - "in house" (stuff you make) and
"third party" (what others make). The authors suggest third party components are more akin
to black boxes.

### Overview of Component Dependencies

Some CBS have components "bundled in" but typically they depend on:

1. services from other components
2. functionalities from external resources (e.g., middleware or OS)

And also have internal dependencies built in that can impact inputs and outputs.
The authors seem to be making the argument that because it's hard to know this set
of dependencies, they need their XML schema.

### The Approach Proposed

The authors want to create this XML schema to:

1. describe the dependencies
2. analyze influence

And it should be flexible enough to:

1. be descriptive
2. define things precisely
3. be easy to change when new information is available

and the result is the Component Based Dependence Model (CBDM) which is XML based,
and broken into two parts: internal and external (hardware, software and services, and causality, provided and required) dependencies. It's basically a dependency graph of components and services. The process of analyzing dependencies takes the following 3 steps:

1. figure out what components are on the system (and configuration)
2. create the CBDM
3. identify component dependencies in the CBS.

They chose XML to be able to query it like a graph, describe pomsets (multi-level, e.g., runtime dependencies), and still express things in text. I just did a Google search and only turned up this paper as a result, so I'm guessing it didn't stand the test of time.

### pomsets

According to the authors, a pomset consists of a sequence of actions in the form of a regex,
where each action could be:

1. describing services not provided by the component
2. actions that the component can provide via some interface
3. actions related to some internal service (not provided by the component)

The authors also state that providing a complete set of metadata (the pomsets) is a limitation because it's likely arduous (and maybe this is one reason why this approach
didn't carry forward). It would be really nice to see an example of this, the description is fairly vague.
 
<hr>

{% bibliography --cited %}
