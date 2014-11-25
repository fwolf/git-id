#! /bin/bash
#====================================================================
# git-id2.sh
#
# Copyright 2014 Fwolf <fwolf.aide+bin.public@gmail.com>
# All rights reserved.
# Distributed under the MIT License.
# http://opensource.org/licenses/MIT
#
# Generate a git version number since last tag.
#
# Format: [closest tag]-[commits since tag]-g[hash(head 7 digits)]
# eg: v1.0-3-g1b0691d
#
# Start from 2014-11-25.
#====================================================================


# Print usage message
function PrintUsage {
    cat <<-"EOF"
Usage: `basename $0` [commit|head]

Parameters:
  commit|head       Sha1 hash or head name of git, default HEAD.
EOF
}


HASH="HEAD"
# Check parameter amount
if [[ $# -lt 1 ]]; then
    HASH="$1"
fi


# Begin

git describe --tags --long --abbrev=7

