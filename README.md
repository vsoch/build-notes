# Build Notes

This is a Jekyll template for taking and sharing notes for the BUILD SC project.
It is a modified version of [notes-jekyll](https://github.com/vsoch/notes-jekyll) 
that is optimized to serve as a note-taking organizational tool. We have changed the following

 - the overall design
 - papers are stored in a private repository, [build-bib](https://github.com/llnl/build-bib).
 - the front page is optimized to share information about the BUILD project.

## Getting started

 - [Updating References](#how-to-update-references) from the private repository with papers
 - [Add papers](#how-to-add-or-view-papers) either manually or with a citation manager
 - [Take notes](#how-to-take-notes) in Markdown, as you typically would
 - [Develop Locally](#develop-locally) using Jekyll natively or via a container
 - [Making changes](#how-to-make-changes) to structure or design of template.
 - [Push to GitHub](#deploy-to-github-pages) to use the GitHub action to automatically deploy the site.

Since the jekyll-scholar plugin doesn't work on GitHub pages, we provide a GitHub action to do it easily.

## How to Update References

If you want to physically add papers, this needs to be done in the [build-bib](https://github.com/llnl/build-bib)
repository, which is private and you should have access to if you are part of the project.
The format of the paper PDFs in the "papers" folder of this repository is expected to match
`papers/%f{Cite Key}-%u%e`.

To then update [references](_bibliography/references.bib) here, you'll need access to the [builb-bib](https://github.com/llnl/build-bib)
repository. Specifically, you should be able to clone it with git. Then you can simply run:

```bash
./pull_references.sh
```
And the references file in [_bibliography](_bibliography) will be updated.

## How to make changes

This is a GitHub repository, so as you would imagine, we can use the general git workflow
to collaborate on notes. This means forking the repository and then cloning your fork:

```bash
git clone git@github.com/<username>/build-notes
cd build-notes
```
And then checkout out a new branch, ideally with a meaningful name:

```bash
git checkout -b notes/myusername-papername
```
And then making changes and pushing to your remote, and opening a pull request.
For more instructions on this process, see the [getting started](https://vsoch.github.io/build-notes/getting-started/) page.

## How to write content

Writing content comes down to editing or creating a Markdown file in the right place.
Yes, you are most definitely free to update pages and notes created by others! If you think something
is fundamentally wrong or warrants discussion, it's probably best to open an [issue first](https://github.com/vsoch/build-notes/issues).

### Papers

Notes on specific papers can be added to the the [_papers](_papers) folder. Specifically, you should name the markdown file to match the paper key in the BibTex, but *remove `:` characters*.

### Thrusts

Each thrust has it's own file in the [thrusts](_notes/thrusts) notes folder. These files already exist so you should not need to add anything.

### Topics

A topic is a general theme that you might want to extract from many papers, and write consolidated notes for (e.g., solvers).
To create a new topic, create a markdown file in the [notes](_notes). You can organize your files in subfolders however you like.

### Writeups

[Posts](_posts) are intended for any kind of more structured writeup that warrants a timestamp. For example, we have a <a href="https://vsoch.github.io/build-notes/how-to-write-notes">writeup</a> that demonstrates all the different kind of formatting you can do.

### Pages

Any higher level page (e.g., this one, or about) generally can be found in the [pages](pages) folder. These pages aren't automatically linked so you would need to manually add them somewhere on the side (e.g., the table of contents on the sidebar).

## Develop Locally

First, you should clone the repository (and likely fork to your own user account first).
The command below would have "vsoch" replaced with your GitHub username.

```bash
git clone git@github.com:vsoch/build-notes
cd notes-jekyll
```

If you have jekyll installed locally, you can typically then install dependencies with
bundle.

```bash
$ bundle install
```

And then run the development server, which will update with changes:

```bash
bundle exec jekyll serve
```

If not, then you can use a container environment to develop. First, build the container:

```bash
$ docker build -t build-notes .
```

And then run it, making sure to bind the correct directory to where it is expected
in the container, and exposing port 4000.

```bash
$ docker run --rm -v "$PWD:/srv/jekyll" -p 4000:4000 notes-jekyll
Configuration file: /srv/jekyll/_config.yml
            Source: /srv/jekyll
       Destination: /srv/jekyll/_site
 Incremental build: disabled. Enable with --incremental
      Generating... 
       Jekyll Feed: Generating feed for posts
                    done in 2.825 seconds.
 Auto-regeneration: enabled for '/srv/jekyll'
    Server address: http://0.0.0.0:4000/notes-jekyll/
  Server running... press ctrl-c to stop.
```

You should then be able to open your browser to [http://127.0.0.1:4000](http://127.0.0.1:4000).
You can then edit files on your local machine, and the server will refresh with changes.

### Docker to Local

If you use a Docker container at any point and then run the local development server,
you'll likely get a permissions error since the Docker user wrote the `_site` folder.
You can easily fix this by entirely removing the site folder - it will be re-generated.

```bash
rm -rf _site
```

## How to make changes

There are several easy ways to make changes, most of which are represented in the [_config.yml](_config.yml).
For the most part, fields are self explanatory. The following sections might be of particular interest:

### Jekyll scholar

The `scholar` section includes information on how to generate references.

```
scholar:
  style: _bibliography/my-ieee.cls
  bibliography: references.bib
  bibliography_template: bibitem-template
  repository: papers
  details_dir: "paper-details"
  details_layout: "details.html"
# details_permalink: "/notes-jekyll/:details_dir/:key:extension"
# Ensure that details are not printed twice
  details_link: ""
```

#### style
The style for your citations is represented with `style`, above to be `_bibliography/my-ieee.cls`

#### bibliography
The default bibliography file is references.bib, also located in [_bibliography](_bibliography)

#### bibliography_template
The template for each reference (`bibliography_template`) is in [_layouts/bibitem-template.html](_layouts/bibitem-template.html)

#### repository
The folder with physical papers (`repository`), named according to their key, is in [papers](papers).

#### details_layout
The details page for each paper (`details_layout`) should be a template in [_layouts/details.html](_layouts/details.html)

#### details_dir
The path where the paper detail files will be rendered (`details_dir`) is `paper-details`. In practice I found that this was not rendered correctly - it was missing the base url. So I hide the default details render via `details_link` being empty, and add my own in the `bibliography_template`. For this same reason, the default `details_permalink` did not seem to work. Finally, in the documentation it noted that `details_link` should be a key, but in practice I found that it did not work.


For all of the above, this generally means that you can change the location of papers pages, your bibliography, and
how the citations are formatted. There are quite a few other settings, and I found it helpful to look
at the [jekyll-scholar README](https://github.com/inukshuk/jekyll-scholar) and the [defaults.rb](https://github.com/inukshuk/jekyll-scholar/blob/master/lib/jekyll/scholar/defaults.rb) file. Everything is exposed from classes to help
style your entries to ordering and types.

## Deploy to GitHub pages

When you push to the main branch, you will trigger a build defined as a [GitHub workflow](.github/workflows/build.yml)
that will deploy the site to GitHub pages.

For more instructions on how to write references into posts, see [notes-jekyll](https://vsoch.github.io/notes-jekyll/about/)
on GitHub pages.

## LICENSE

This code has inherited the original [LICENSE](LICENSE) that must be preserved
from the repositories where it originates from.
