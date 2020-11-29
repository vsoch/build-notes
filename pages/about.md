---
layout: page
title: Overview
css: ["about.css", "animate.css", "morphext.css"]
js: ["morphext.min.js", "about.js"]
permalink: /about/
---

This proposal aims to reduce the complexity of integration of software packages. Growing number of packages increases the complexity of integrating them in applications. This is a significant problem, which is time consuming and often results in sub-optimal use of software packages, such as continued use of outdated versions because the cost of moving to a new version is too high. Currently, software package compatibility is mostly managed manually by individual projects, even in cases where they share common third-party packages. There are many examples of this at LLNL and externally. This creates a large workload for individual projects and often makes them reliant on old versions, so they cannot take advantage of newer features, performance improvements, bug-fixes, etc. This is especially problematic when packages are changing rapidly, like in the area of data science. This proposal presents four thrust areas to solve this problem:


 - **Thrust 1** – Develop a formal specification to determine compatibility, focusing on Application Binary Interfaces (ABI) between packages. This includes the development of a tool to programmatically construct and verify compatibility models and a set of use cases from proxy apps that demonstrate mixed language/runtime applications can be built and verified.
 - **Thrust 2** – Develop binary analysis tools to determine which packages can be integrated together, even when built through different means (e.g., manually or with a package manager). This requires reverse engineering stripped binaries with no debug information to find entry/exit points, exported data types/structures, other ABI relevant semantics and metadata, and validating equivalence or near equivalence in function behavior.
 - **Thrust 3** – Quickly find the right combination of versions to satisfy constraints. This thrust builds on top of verifiable compatibility models and binary analysis. For this area, the team wants to determine if modern solvers can be used to solve full-scale models quickly enough to be practical and what types of encodings and heuristics are necessary to reliably solve this problem.
 - **Thrust 4** – Find the optimal configuration that is closest to known and tested versions of the code. They want to leverage the large set of library configurations (~4,000 spack packages) to train a machine learning model to find optimal configurations.

See the [getting-started]({{ site.baseurl }}/getting-started/) page for instructions
on how to write notes or ask for help.

