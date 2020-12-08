---
toc: 1
---

# OPIUM: Optimal Package Install/Uninstall Manager

## Overview

This {% cite tucker+:icse07-opium %} is a package manager developed by some guys at UCSD circa 2007. The authors
claim that it is complete (if a solution exists, it will be found) and allows for
a new optimization metric to minimize installed packages (via an objective function).
Their tool uses [Pueblo](https://ieeexplore.ieee.org/document/1395654) for the pseudo-boolean solver, the [GNU Linear Programming Kit](https://www.gnu.org/software/glpk/) for the ILP solver, and the foci theorum for producing unsatisfiability proofs. 

### Why dynamic linking?

Static linking is when libraries are included alongside a binary (and available immediately) and dynamic linking is when they are found on the host ([ref](https://www.geeksforgeeks.org/static-and-dynamic-linking-in-operating-systems/))

Ah! This might be how we could parse a binary and figure out it's dependencies (from the source above):

> Every dynamically linked program contains a small, statically linked function that is called when the program starts. This static function only maps the link library into memory and runs the code that the function contains. The link library determines what are all the dynamic libraries which the program requires along with the names of the variables and functions needed from those libraries by reading the information contained in sections of the library. 

Dynamic linking can be more efficient because you just load libraries into memory once.

### The Three Problems of Package Management

 - **The Install Problem** can a new package be installed? If so, how?
 - **Minimal Install Problem** figure out the optimal way to install based on minimizing an objective function.
 - **Uninstall Problem**: Given a new package to install, figure out the minimal to *remove* to make it work.

The authors solve each of the problems above as follows:

 - **The Install Problem** using a SAT solver on some encoding of the distribution.
 - **Minimal Install Problem** this encoding is essentially a "pseudo-boolean" problem that solves this issue, something called [Pueblo](https://ieeexplore.ieee.org/document/1395654)?
 - **Uninstall Problem**: they tackle this by starting with a package that isn't installable, and then figuring out what to remove to make it work.

### Terms

 - **Installation Profile** the set of packages installed on a machine. If it's valid, all dependency clauses (requires, conflicts) are satisfied.


## The Install Problem

apt-get works by traversing the dependency graph and creating a set of packages that are needed, but it doesn't go back to look again so it's less complete. Opium works by creating a variable for each package, and then creating constraints (as equations) for each one that are represented as boolean conditions to evaluate to True or False.

## The Minimal Install Problem

Given a few sets of solutions, they can assign a cost to things like adding extra packages,
and then use a SAT solver and bias toward a particular choice (with fewer extras, or minimal size).

## The Uninstall Problem

If a solution isn't found, the solver returns a "resolution proof tree" which shows why it wasn't. The leaves of the tree are packages that can be tested to be removed to see if a solution is then possible.

Pages 5-9 have algorithms and proofs for how it works.

<hr>

{% bibliography --cited %}
