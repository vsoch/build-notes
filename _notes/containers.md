---
title: Containers Investigation for Build
categories: containers
tags: [containers]
maths: 1
toc: 1
---

{% include toc.html %}

## Overview

One of the particularly hard aspects of compatibility that we plan to investigate under BUILD is the relationship between the binaries in containers with the binaries on the host system.  Containers in the cloud encapsulate a software ecosystem, generally for a single application and all of its dependencies for some base operating system.  Used as initially intended, containers enable very complex applications to be used portably across machines. However, in HPC, the software ecosystem cannot be fully encapsulated as libraries like MPI, GPU runtimes, and libfabrics typically require access to hardware and drivers on the host OS.  There are subtleties around how best to bindmount libraries and other software from the host OS into a container while ensuring compatibility.  In most cases today, compatibility is not ensured, and containers are simply run until they fail (due to an OS update or some other incompatibility).

BUILD aims to do better by doing detailed comparison of host and containerized software stacks and selecting the best interfaces to use for maximum container portability and performance.  These types of interfaces are particularly important for machine learning applications that are a) hard to build and b) require good performance to run. We will investigate how best to package HPC and ML applications in containers and how to select, validate, and maintain a good binary interface between container and host OS’s.

## Proposed R&D Tasks
Proposed research and development topics include (but are not limited to) the following:

### 1. Understand models of container ABI compatibility
This can include MPI libraries, GPU libraries, libfabrics, scheduler integration, or any interface that needs to remain compatible to ensure container portability. We will conduct studies to determine rules around ABI layer selection, analysis techniques to compare ABI compatibility between containers and hosts, and best practices for maintaining compatibility over time.

### 2. Research ways to dynamically assemble software stacks around ABI constraints.  
Running a container with hardware support on a host OS requires us to marry two or more independently curated software ecosystems (container and run host(s)) together. Given a set of ABI constraints, e.g. from several base OS or library versions, can we build a container that satisfies all of them? Can two applications be consolidated based on ABI requirements, or do they need to be in separate containers?How can we construct maximally performant and portable software stacks? 

### 3. What are the inherent complexities around integrating modern software stacks with HPC?
Modern open source software stacks evolve very rapidly, and it can be very hard for HPC applications to keep up with this rate of change. Often, rapid evolution comes at a price -- these stacks are targeted at very specific environments, and adapting them for others (like HPC) can be difficult. For example, TensorFlow, a very popular machine learning tool, is maintained specifically for Google’s internal machines, and can be very difficult to build for HPC systems. Other language ecosystems like Python, Ruby, R, and JavaScript can also be hard to adapt for maximum performance.  How can we derive HPC-compatible builds of tools like these? How can we leverage host HPC software stacks from within portably built containers, and how can we guarantee portability over time?

### 4. How can we build infrastructure to support ABI-based dependency resolution?
BUILD aims to build dependency resolvers that check ABI and solve around ABI conflicts automatically.  There will likely need to be databases of ABI and build information to back such a resolver, and we have not, so far, investigated how best to build these. We will leverage Dr. Sochat’s expertise both in software ecosystems, containers, and scientific workflow design to build such infrastructure.

<hr>

## Ideas for Projects

Still unrelated to the R&D tasks above, the following projects are inspired by papers, and could be useful
in some way integrated into the tasks above.

### Decision Comparison

If we need to (superficially) compare how package managers make decisions, we could select a small number of packages,
and akin to how they did in {% include paper.html key="abate-2013-modular-package-manager" %} attempt to install
each package across different package managers (e.g., apt-get, yum, aptitute, etc.) and parse the output to determine how
the managers make decisions {% cite abate-2013-modular-package-manager %}. We would then want to look at how each one works and map the behavior that we see to 
some solver or heuristic.

This would help to understand how well-known package managers work, and to familiarize with them so that
if we wanted to imagine changing them to be more modular, we might have a sense of how to go about it.

### Bootstrap CUDF

I was reading in {% cite abate-2013-modular-package-manager %} that CUDF can allow for definition of "additional properties."
Would our first efforts want to try and define additional properties related to ABI compatability, and just use standard CUDF? I realize now that I don't have a sense of if CUDF is a good idea/direction or not. Based on the papers presenting it, it seems to be?

<hr>

{% bibliography --cited %}
