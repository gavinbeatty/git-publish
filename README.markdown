git-publish
===========
Gavin Beatty <gavinbeatty@gmail.com>

git publish: a simple shell script to ease the unnecessarily complex task of
"publishing" a branch, i.e., taking a local branch, creating a reference to it
on a remote repo, and setting up the local branch to track the remote one, all
in one go.

    Usage: git publish [-v] [-n] [-f | -d] [<branch> [<remote>]]

    <branch> is the branch to publish -- defaults to `git symbolic-ref HEAD`
    <remote> is the remote to publish to -- defaults to origin

    NOTE: <branch> and <remote> have the inverse order of git push.
          Publishing a specific branch is more common than publishing to a
          specific remote.

    -v -- print each command as it is run.
    -n -- don't run any commands, just print them.
    -f -- don't do any checks on existing tracking branches etc. before
          publishing.
    -d -- delete the published branch from the remote repo and stop tracking.


Dependencies
------------

* getopts: in POSIX.
* sed: in POSIX.
* git: it is very much not in POSIX.


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

No install facilities are provided as it would be a _shockin'_ _holy_ waste of
a Makefile.

e.g.,
    install -m 0755 git-publish /usr/local/bin


