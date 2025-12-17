# janet-lsp.port

A FreeBSD port.

This is now merged and will be archived.

There is one awkward dependency: cmd.

`janet-lsp` has forked the original and is ahead by 8 commits. Good news is that
judge works with that version too. The bad news is that `jpm` gets confused and
won't make a lockfile.

Since all the lockfile would do is record git hashes we just use GH_TUPLE
which documents the identical information. We have to order how we `jpm install`
as well.


```
# cd /usr/ports/devel
# git clone git@github.com:dmarker/janet-lsp.port.git janet-lsp
# cd janet-lsp
# make install clean
```
