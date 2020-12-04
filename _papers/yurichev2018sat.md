---
toc: 1
---

## SAT/SMT by Example

### Overview

This {% cite yurichev2018sat %} is an entire book on solvers! Despite the name, the document appears to be dated in 2020. 

- **SMT Solvers** take systems in arbitrary format. The book (starting on page 13) gives many applied examples of using software to solve a system of equations (even XKCD!) and mentions that SMT solvers are really the front-ends to SAT solvers. E.g., we take some boolean logic, do one-hot encoding (called "bit blasting), and get a SAT solver problem.
- **SAT solvers** are limited to boolean equations in CNF form
- **CNF form** is basically a bunch of sums, and's and or's ([definition](https://en.wikipedia.org/wiki/Conjunctive_normal_form)) or what I'd think of as boolean logic.

This is a long book, so I'm not decided how to best take notes yet, possibly it's best to use as a reference.

<hr>

{% bibliography --cited %}
