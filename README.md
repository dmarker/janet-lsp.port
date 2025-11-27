# janet-lsp.port

A FreeBSD port.

There is one awkward dependency: cmd.

`janet-lsp` has forked the original and is ahead by 8 commits. Good news is that
judge works with that version too. The bad news is that `jpm` gets confused and
won't make a lockfile.

But its not that hard to cobble one together.

The real tradjedy here is that a janet-lsp.jimage is an available asset on
github. You can literally `janet -i janet-lsp.jimage`. But strangely you can
not use that with jpm(1) to create a standalone exe.

If I actually wanted this port accepted I would need to download versions in
the created lockfile instead of doing `jpm deps -l`. But then again I could
just make a one line shell script and use the jimage asset. I just prefer to
`jpm build` an executable.

```
# cd /usr/ports/devel
# git clone git@github.com:dmarker/janet-lsp.port.git janet-lsp
# cd janet-lsp
# make install clean
```
