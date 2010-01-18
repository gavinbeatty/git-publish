#!/bin/sh

## git publish: a simple script to ease the unnecessarily complex task of
## "publishing" a branch, i.e., taking a local branch, creating a reference
## to it on a remote repo, and setting up the local branch to track the remote
## one, all in one go.
##
## Usage: git publish [-v] [-n] [-f | -d] [<branch> [<remote>]]
##
## <branch> is the branch to publish -- defaults to `git symbolic-ref HEAD`
## <remote> is the remote to publish to -- defaults to origin
##
## -v -- print each command as it is run.
## -n -- don't run any commands, just print them.
## -f -- don't do any checks on existing tracking branches etc. before
##       publishing.
## -d -- delete the published branch from the remote repo and stop tracking.
##
## git publish is a modified version of git-publish-branch, found:
## http://git-wt-commit.rubyforge.org/git-publish-branch
##
## As this is a fork of git-publish-branch, it retains the original copyright.
## git-publish-branch Copyright 2008 William Morgan <wmorgan-git-wt-add@masanjin.net>.
##
## The modifications are copyright.
## git publish Copyright 2010 Gavin Beatty <gavinbeatty@gmail.com>.
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or (at
## your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You can find the GNU General Public License at:
##   http://www.gnu.org/licenses/

set -u
set -e

usage() {
    echo "Usage: git publish [-n] [-f] [-v] [-d] [<branch> [<remote>]]"
}
die() {
    echo "error: $@" >&2
    exit 1
}

doit() {
    if test -n "$verbose" ; then
        echo "$@"
    fi
    if test -z "$dryrun" ; then
        "$@"
    fi
}

main() {
    dryrun=""
    force=""
    verbose=""
    delete=""
    if ! type "git" 1>/dev/null 2>&1 ; then
        die "Please install git."
    fi
    if ! git rev-parse --git-dir >/dev/null 2>&1 ; then
        die "Not a git repository (or any of the parent directories)"
    fi

    while getopts ":hnfvd" opt ; do
        case "$opt" in
        h)
            usage
            exit 0
            ;;
        n)
            dryrun="true"
            verbose="true"
            ;;
        f)
            force="true"
            ;;
        v)
            verbose="true"
            ;;
        d)
            delete="true"
            ;;
        \?)
            die "invalid option: -${OPTARG}"
            ;;
        *)
            die "invalid getopts return: $opt"
            ;;
        esac
    done
    shift "$(expr "$OPTIND" - 1)"
    OPTIND=1

    branch="HEAD"
    remote="origin"

    if test $# -gt 0 ; then
        branch="$1"
    elif test $# -gt 1 ; then
        remote="$2"
    elif test $# -gt 2 ; then
        usage >&2
        exit 1
    fi
    branch="$(git symbolic-ref "$branch")"
    branch="$(echo "$branch" | sed -e 's|^refs/heads/||')"

    if test -n "$delete" ; then
        doit git push "$remote" ":refs/heads/${branch}"
        doit git config --unset "branch.${branch}.remote"
        doit git config --unset "branch.${branch}.merge"

    else
        if test -z "$force" ; then
            local_ref="$(git show-ref "heads/${branch}" || e=$?)"
            if test -z "$local_ref" ; then
                die "No local branch ${branch} exists!"
            fi
            remote_ref="$(git show-ref "remotes/${remote}/${branch}" || e=$?)"
            if test -n "$remote_ref" ; then
                die "A remote branch ${branch} on ${remote} already exists!"
            fi
            remote_config="$(git config "branch.${branch}.merge" || e=$?)"
            if test -n "$remote_config" ; then
                die "Local branch ${branch} is already tracking ${remote_config}"
            fi
        fi

        doit git push "$remote" "${branch}:refs/heads/${branch}"
        doit git config "branch.${branch}.remote" "$remote"
        doit git config "branch.${branch}.merge" "refs/heads/${branch}"
    fi
}

trap "echo \"caught SIGINT\" ; exit 1 ;" INT
trap "echo \"caught SIGTERM\" ; exit 1 ;" TERM
trap "echo \"caught SIGHUP\" ; exit 1 ;" HUP

main "$@"

