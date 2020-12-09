---
toc: 1
---

## Easybuild: Building Software with Ease

### Overview

Easybuild {% cite hoste-easybuild-pyhpc-2012 %} is similar to spack in that it is a repository of knowledge about how to build
packages, and is also implemented in Python. It sounds like kenneth Hoste (the creator) first made Easybuild because he realized how
hard it was to consistently maintain packages. I get the sense (and I think this is confirmed
by user surveys) that EasyBuild has a larger HPC admin audience, and spack has a larger
(generic) or non-admin user base.

#### Issues with Installing Packages

These are reported issues that inspired creation of EasyBuild at UCGhent:

 - **Incompleteness**: Most software requires external libraries (outside the install directory)
 - **Non-standard procedure**: every install is a custom, gnarly script, or even interactive!
 - **custom-built scripts**: Instead of make, cmake, etc., packages add their own custom build scripts.
 - **Hard coded parameters**: are usually in the configuration files / install scripts.


The authors then state that the qualities they would want are:

 - **flexibility**: different install procedures should be supported with minimal effort
 - **co-existence of versions**: so you never need to remove installed software
 - **dependency handling**: automatic dependency resolution outside of a package manager
 - **sharing implementations of install procedures**: or basically creating community, reducing redundancy.

The last point advocates for a modular "plug and play" architecture.

### Usage

There is a main command `eb` that generally works with a main configuration file, and then you
"point it at" easyconfig files to build packages. It's fairly nice that it only depends on Python
and environment modules, although I expect the latter to be a limiting factor in extending to environments
outside of HPC. It automatically generates an environment module for each package installed, and this is how
the same package with different versions can be installed side by side.

Generally, there are different tools (e.g., easyblocks, extension module) and configuration files
that help to specify and then install a package. It's pretty neat that easyblocks implements sub modules
as actual packages (e.g., EB_7zip). Basically, they are representing software install procedures in modules
so they can be shared and extended. Easybuild also has a `flietools` module to provide wrappers to shell commands,
and a `toolchain` package for supporting compilers.
 
### Features

Other features of easybuild include keeping track of build logs, archiving successful easyconfig files 
along with information about EasyBuild version, etc. when it was run, interactive installers,
parallel installs, regression and unit testing, and "automatic dependency resolution" or looking for easyconfig files that need to be installed.

The configuration file example basically looks like Python lists, dicts, and strings. The rest
of the paper has example code and description to do a build.


<hr>

{% bibliography --cited %}
