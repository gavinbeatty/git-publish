git-publish
===========
Gavin Beatty <gavinbeatty@gmail.com>

git publish: a simple shell script to ease the unnecessarily complex task of
"publishing" a branch, i.e., taking a local branch, creating a reference to it
on a remote repo, and setting up the local branch to track the remote one, all
in one go.

From the manpage:

    NAME
           git-publish - push a git branch to a remote and track it

    SYNOPSIS
           git-publish [OPTIONS] [<remote>]

    DESCRIPTION
           Publish <branch> to <remote> and configure the local <branch> to track
           <branch> on the remote end.

    OPTIONS
           -v, --verbose
               Print the git commands before executing them.

           -n, --dry-run
               Don’t run any of the git commands. Only print them, as in -v.

           -f, --force
               Don’t run any tests on the local and remote branches to see if they
               are already tracking branches, etc.

           -d, --delete
               Delete the specified <branch> from <remote> and stop tracking it.

           -b, --branch=<branch>
               The branch we wish to publish.

           -t, --tracking-only
               Don’t push any local branches or delete any remote ones - only
               change tracking configuration.

           --version
               Print version info in the format ´git publish version $version´.

           <remote>
               The remote to which you want to publish.

    EXIT STATUS
           0 on success and non-zero on failure.

    AUTHOR
           Gavin Beatty <gavinbeatty@gmail.com> Forked from git-publish-branch

    RESOURCES
           Website: http://code.google.com/p/git-publish/

    REPORTING BUGS
           Please report all bugs and wishes to <gavinbeatty@gmail.com>

    COPYING
           git-publish Copyright (C) 2010 Gavin Beatty, <gavinbeatty@gmail.com>

           Originally a fork of git-publish-branch, and as such, retaining
           copyright: http://git-wt-commit.rubyforge.org/git-publish-branch
           git-publish-branch Copyright (C) 2008 William Morgan
           <wmorgan-git-wt-add@masanjin.net>.

           Free use of this software is granted under the terms of the GNU General
           Public License version 3, or at your option, any later version.
           (GPLv3+)


Dependencies
------------

* sh: in POSIX
* sed: in POSIX.
* git: it is very much not in POSIX.

As such, git-publish should be portable across all platforms that Git supports.


License
-------

git publish is a modified version of git-publish-branch, found:
http://git-wt-commit.rubyforge.org/git-publish-branch

As this is a fork of git-publish-branch, it retains the original copyright.
git-publish-branch Copyright 2008 William Morgan <wmorgan-git-wt-add@masanjin.net>.

The modifications are copyright.
git publish Copyright 2010 Gavin Beatty <gavinbeatty@gmail.com>.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or (at
your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You can find the GNU General Public License at:
http://www.gnu.org/licenses/


Install
-------
    make

Default prefix is `/usr/local`:
    sudo make install

Select your own prefix:
    make install prefix=~/


