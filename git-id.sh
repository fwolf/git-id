#! /bin/bash
#====================================================================
# git-id.sh
#
# Copyright 2009-2014 Fwolf <fwolf.aide+bin.public@gmail.com>
# All rights reserved.
# Distributed under the MIT License.
# http://opensource.org/licenses/MIT
#
# Generate a common git version number.
#
# Format: [repo name]-[branch]-[hash(head 8 digits)]-r[total revisions]
# eg: git-id-master-e6835ae5-r2
#
# Start from 2009-08-10.
#====================================================================


# Print usage message
function PrintUsage {
    cat <<-"EOF"
Usage: `basename $0` [commit|head]

Parameters:
  commit|head       Commit id(sha1 hash) or head name of git, default HEAD.
EOF
}


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
BRANCH=`git branch | grep ^* | awk '{print $2}'`

# Get sha1
SHA1=`git show $HASH |head -1 |awk '{print $2}' |head -c 8`

# Get revision
REV=`git log --pretty=oneline |wc -l`

# Print result
echo $REPO-$BRANCH-$SHA1-r$REV

