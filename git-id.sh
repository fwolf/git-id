#! /bin/bash
#====================================================================
#   git_id.sh
#
#   Copyright (c) 2009, Fwolf <fwolf.aide+bin.public@gmail.com>
#   All rights reserved.
#   Distributed under the GNU Lesser General Public License, version 3.0.
#
#   Version 0.01, since 2009-08-10.
#
#   Generate a common git version number.
#
#   Rule: repo_name-branch-sha1(head-8-digi)-revision
#====================================================================


# Print usage message
function PrintUsage {
    cat <<-"EOF"
Usage: `basename $0` [hash]

Parameters:
  hash          Sha1 hash of git, default HEAD.
EOF
} # end of func PrintUsage


HASH="HEAD"
# Check parameter amount
if [[ $# -lt 1 ]]; then
    HASH="$1"
fi


# Begin

# Check if is in a git repository
if [ ! -d '.git' ]; then
    echo 'Must exec in a git repository.'
    exit 1
fi

# Get repository name
REPO=`git config remote.origin.url`
REPO=${REPO##*:}
REPO=${REPO##*/}
# Remove tailing .git
REPO=${REPO%.*}

# Get branch
BRANCH=`git status |head -1 |awk '{print $4}'`

# Get sha1
SHA1=`git show $HASH |head -1 |awk '{print $2}' |head -c 8`

# Get revision
REV=`git log --pretty=oneline |wc -l`

# Print result
echo $REPO-$BRANCH-$SHA1-r$REV
