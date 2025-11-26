# janet-lsp.port

A FreeBSD port.

There is one awkward dependency: cmd.
`janet-lsp` has forked the original and is ahead by 8 commits.
Good news is that judge works with that version too.
The bad news is that `jpm` gets confused and won't make a lockfile.

But its not that hard to cobble one together.

```
# cd /usr/ports/devel
# git clone git@github.com:dmarker/janet-lsp.port.git janet-lsp
# cd janet-lsp
# make install clean
```
