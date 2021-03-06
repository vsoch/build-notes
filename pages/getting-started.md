---
layout: page
title: How do I take notes?
css: ["about.css", "animate.css", "morphext.css"]
js: ["morphext.min.js", "about.js"]
permalink: /getting-started/
---

### Overview

This is a Jekyll template that will make it easy to:

1. Add references to `references.bib` that link to papers in [build-bib](https://github.com/llnl/build-bib).
2. Create pages with notes and automatically render and cite references on any page.
3. Push to the main branch and trigger a build for GitHub pages
4. Search or otherwise interact with the interface

The organization along with each point above are explained in more detail below, and if you want more instructions for
overall site configuration, see [the repository README](https://github.com/vsoch/notes-jekyll/#notes-jekyll).

#### 1. Organization

The template is organized to allow for several ways for you to take notes. These are the directories
that you might be interested in:

```bash
.
├── _notes
├── pages
├── _papers
├── _posts
└── _terms
```

Of the above, everything with an underscore is for notes, and `pages` is more appropriate
for a site page (e.g., this one). Continue reading and see section 3 for how to choose the section
to take notes in.


#### 2. References

If you simply want to interact with the references here, the `references.bib` in the base
of the repository can be linked to the `papers` folder and you can open them in your citation
manager of choice. An example manager tool is [BibDesk](https://bibdesk.sourceforge.io/).
By default, you should expect the name of the paper pdf to match the name of the citation 
(and BibDesk will do this automatically for you, this is called "AutoFile") and it's
suggested to do a format like `papers/%f{Cite Key}`. You can also just add citations
and papers manually, it's up to you!

#### 3. How to take notes

Once you have your papers, you of course want to take notes! The nice thing is that these
are all in Markdown, and you can cite or insert references almost anywhere. Basically, you have a few options:

##### Papers

Specific notes on papers should go under `_papers`, with the name of the paper corresponding
to the key in the BibTex (with `:` characters removed!) For each paper, it's helpful to include
an overview, sections that you think are appropriate to explain the paper, figures or tables if
you think they are super important, possibly a list of terms, and even a TLDR for a quick "too long
didn't read, give me the gist." If you want to start with a template or example, it's easy
enough to copy the file of another paper.

##### Terms

For terms that appear across papers, you can create a markdown file (named by the term, e.g., `cudf.md`)
in the `_terms` folder. You can link to it directly anywhere with this snippet:

```
{% raw %}{% include term.html key="cudf" %}.{% endraw %}
```

E.g., when I read the many Abate papers I found lots about CUDF, and found it easier
to use the link above.

##### Topics

A topics page can be thought of as a general note, e.g., we have one already for containers,
and one I called "flow" that talks about general named things in the flow of package management.
Any concept that isn't appropriate for a term (and obviously isn't a paper) can go here. 

##### Writeups

For anything that is temporal in nature, or something that might be akin to a more complete writeup,
this can be put in the `_posts` folder and be rendered as a post. Currently we have the "How to write a post"
page here.

##### Thrusts

Each thrust has it's own file in the <a href="https://github.com/{{ site.repository }}/tree/main/_notes/thrusts" target="_blank">thrusts</a> notes folder. These files already exist so you should not need to add anything.


For all of the above, references are generally available, so you can cite anywhere on the page (see following sections).
I chose this approach because I like writing in Markdown. While we could investigate solutions to run a web server and render a PDF, the simpler approach of using Markdown will likely be more comfortable for users with different
editor preferences.


##### Citations

The simplest thing you might want to do is cite something. For example,
if I type:

```
{% raw %}{% cite metz2011nonrigid %}{% endraw %}
```

If you want to cite a particular set of pages or lines, you can do:

```
{% raw %}{% cite metz2011nonrigid --locator 23-5 %}{% endraw %}
```

And then I can include the entire list of references, usually at the end of the page, as follows:

```
{% raw %}{% bibliography --cited %}{% endraw %}
```

You can remove the `--cited` to include all references, regardless of being mentioned or
not. And then I can easily render the citation {% cite hinsen2019dealing %}.
Or make a citation that references lines {% cite metz2011nonrigid --locator 23-5 %}.
You should be able to click either of those numbers and be taken to the references at the bottom.


##### References

In the same spirit as the above, you can print the reference for any particular citation
as follows:

```
{% raw %}{% reference metz2011nonrigid %}{% endraw %}
```

That renders to the following (and note the class is "citation" if you want to edit the
style):

{% reference metz2011nonrigid %}


##### Quotes

You might also want to quote text, verbatim. That might look like this, for the same
paper:

```
{% raw %}{% quote metz2011nonrigid %}
Lorem ipsum dolor sit amet, consectetur adipisicing elit,
sed do eiusmod tempor.

Lorem ipsum dolor sit amet, consectetur adipisicing.
{% endquote %}{% endraw %}
```

And here is the rendered version of that.

{% quote hinsen2019dealing %}
Lorem ipsum dolor sit amet, consectetur adipisicing elit,
sed do eiusmod tempor.

Lorem ipsum dolor sit amet, consectetur adipisicing.
{% endquote %}

{% bibliography --cited %}

<fieldset class="field-set" markdown="1">
<legend class="leg-title">Examples</legend>
For an example post see the <a href="https://vsoch.github.io/notes-jekyll/registration">Registration</a> example page,
and the <a href="https://vsoch.github.io/notes-jekyll/how-to-write-notes">How to Write Notes</a> page
for formatting examples.</span>
</fieldset>

##### Links to Papers

When taking notes specific to a paper (e.g., a file in `_papers`) it's common to want to link to another paper.
For example, I came across CUDF in two places, and wanted to link to the correct section. To do this, I could
insert an include as follows:

```html
{% raw %}See {% include paper.html key="abate+ocaml14-pkg-manager-prefs" title="this paper for more on CUDF" id="cudf" %}.{% endraw %}
```
This would link me directly to `/build-notes/papers/abate+ocaml14-pkg-manager-prefs#cudf`, with text for the link as
I specified. The only required attribute is the key, however, so I could just do this:

```html
{% raw %}See {% include paper.html key="abate+ocaml14-pkg-manager-prefs" %}.{% endraw %}
```

And it would link to the top of the page with text `[ref]`.


##### Links to Terms

Since terms can appear across papers, it's helpful to put them into their own organization.
For this purpose, we have a `_terms` folder where you can create a term file, and link to as follows:

```
{% raw %}{% include term.html key="cudf" %}.{% endraw %}
```

The above would link to the term page "cudf" in the file `_terms/cudf.md`.

#### 4. Metadata for notes

Regardless of where you create the Markdown file, you can follow a general pattern
of defining metadata to help you to add functionality like equation formatting, or metadata like
tags and categories. Here is an example template that demonstrates some of these 
fields:

```yaml
---
title: How to write notes
categories: [about]
tags: [jekyll]
datacamp: 1
maths: 1
toc: 1
---
{% raw %}
{% cite keyToReference %}

{% quote metz2011nonrigid %}
This is an example of a cited quote.
Lorem ipsum dolor sit amet, consectetur adipisicing elit,
sed do eiusmod tempor.

Lorem ipsum dolor sit amet, consectetur adipisicing.
{% endquote %}

<hr>

{% bibliography --cited %}
{% endraw %}
```

The above makes a few citations (including a post) and has references at the bottom.

##### Tags and Categories

Tags are a strategy for grouping notes. For example, I might tag notes with authors, or other relevant
metadata.  You can add a list of tags to any post front end matter as follows:

```yaml
tags: [vsoch,manbat]
```

You don't need to define tags a-priori - they will render regardless. For categories,
you'll need to edit the `_data/categories.yml` file to add names and slugs. A category
is more appropriate for grouping information. For example, for the dummy papers here,
I might have a category of registration. You can also define categories in front end matter:

```yaml
categories: [registration]
```

A single string should work as well.

## Thanks

This template would not be possible without [notes-jekyll](https://github.com/vsoch/notes-jekyll), 
[notetheme](https://github.com/dinhanhthi/notetheme) and the
[jekyll-scholar](https://github.com/inukshuk/jekyll-scholar) plugin for citation management.
Thank you!

## Support

If you have any questions or want to request a feature, please don't hesitate
to [open an issue](https://github.com/{{ site.repository }}/issues). 
