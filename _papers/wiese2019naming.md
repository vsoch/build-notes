---
toc: 1
---

## Naming the Pain in Developing Scientific Software

### Overview

The paper {% cite wiese2019naming %} strongly reflects the state of research software engineering - a large number of us don't have official/extensive training in computer science or software engineering, and thus this leads to what the author is calling "pains." This paper is cool because they attempt to characterize these pains, namely building a taxonomy of 2,110 problems across 1,577 R developers. Areas of pain include:

 - technical-related
 - social-related
 - scientific-related

And developing research software is hard because:

 - requirements constantly chang
 - RSEs need domain knowledge and programming expertise
 - architectures (e.g., communication) change frequently
 - tooling is often not open source, or not community efforts (and I'd guess everyone re-invents the wheel).

And the primary complaints they found are:

 - lack of documentation 
 - poor compatability across platforms
 - lack of a formal reward system


#### Who is the Scientific Software Developer?

They tried to filter (by asking) to only developers of scientific software.

 - Most are male (88%)
 - It's fairly globally diverse, with most in Europe (49%) and the US (34%)
 - 80% are working toward or have a PhD
 - Only 20% call themselves software engineers
 - fields / domains are pretty much everything


#### The Pains

##### Technical Related

Technical problems are over 70% of reported issues. Top issues include:

 - software requirements and management
 - functional requirements
 - documentation
 - software testing/debugging

![{{ site.baseurl }}/assets/img/notes/wiese-technical-problems.png]({{ site.baseurl }}/assets/img/notes/wiese-technical-problems.png)

and of course you can see the entire breakdown in the figure above!
They think that this category is high possibly because there are fewer
respondents with CS backgrounds (3%).

##### Social Problems

Top social problems include:

- Lack of Time
- Publicity (e.g., we need journals like JOSS)
- Emotional aspects (no recognition sucks)
- Communication and Collaboration (lack of scientific software community)
- Lack of Support (e.g., smaller user base == less feedback)

![{{ site.baseurl }}/assets/img/notes/wiese-social-problems.png]({{ site.baseurl }}/assets/img/notes/wiese-social-problems.png)

##### Scientific Related Problems

- Data handling pains (poor community standards, data quality, management, privacy, sharing)
- reproducibility (people still don't care sometimes)
- scope of software (often unclear)
- background (mapping between domain and coding skills)

![{{ site.baseurl }}/assets/img/notes/wiese-scientific-problems.png]({{ site.baseurl }}/assets/img/notes/wiese-scientific-problems.png)

### Solutions

The authors state that solutions aren't the goal of the paper, but they point out that Software carpentry encourages:

- using version control
- turning bugs into test cases
- consistent style/formatting of code

These, however, are mostly technical and don't address the social / scientific problems
mentioned previously. The authors say that based on their findings, past work doesn't properly quantify and then address these "softer" problems, and they anticipate more research to come (see Table 1 at end of paper).

### Datasets

 - The research data is available at [https://github.com/utfpr/NamingThePain](https://github.com/utfpr/NamingThePain).

<hr>

{% bibliography --cited %}
