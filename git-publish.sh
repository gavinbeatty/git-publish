#!/bin/sh

set -e
set -u

usage() {
    echo "Usage: $(basename -- "$0") [-n | -t | -v] [<remote>] [<branch>]"
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
    branch="HEAD"
    remote="origin"

    dryrun=""
    teachrun=""
    verbose=""
    if ! type "git" 1>/dev/null 2>&1 ; then
        die "Please install git."
    fi
    if ! git rev-parse --git-dir >/dev/null 2>&1 ; then
        die "Not a git repository (or any of the parent directories)"
    fi

    while getopts ":ntv" opt ; do
        case "$opt" in
        n)
            dryrun="true"
            ;;
        t)
            teachrun="true"
            dryrun="true"
            verbose="true"
            ;;
        v)
            verbose="true"
            ;;
        \?)
            die "invalid option: -${OPTARG}"
            ;;
        *)
            die "invalid getopts return: $opt"
            ;;
        esac
    done
    branch="$(git symbolic-ref "$branch" | sed -e 's|^refs/heads/||')"

    if test -z "$teachrun" ; then
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
}

trap "echo \"caught SIGINT\" ; exit 1 ;" INT
trap "echo \"caught SIGTERM\" ; exit 1 ;" TERM
trap "echo \"caught SIGHUP\" ; exit 1 ;" HUP

main "$@"

