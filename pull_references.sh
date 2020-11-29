#!/bin/bash

# Retrieve the updated references from the llnl/builb-bib private repository
# This requires the running using to have permission to do so

echo
echo "************** Updating references.bib **********************"

here="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
repo="git@github.com:llnl/build-bib"
tmpdir=$(mktemp -d)

git clone ${repo} ${tmpdir}
retval=$?

function cleanup {
    if [ -d "$tmpdir" ]; then
        printf "Cleaning up ${tmpdir}..."
    fi
}

if [ "$retval" != 0 ]; then
    printf "There was an error cloning $repo. Do you have permission to?"
    cleanup
    exit 1
fi

if [ ! -f "$tmpdir/build.bib" ]; then
   printf "The build.bib expected at the root of the repository does not exist."
   cleanup
   exit 1
fi

cp ${tmpdir}/build.bib $here/_bibliography/references.bib
cleanup
