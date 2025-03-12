if test -z "$GOPATH"
    set -Ux GOPATH ~/Workspace/Programming
end

if test -z "$GOBIN"
    set -Ux GOBIN $GOPATH/bin
end

if test -z "$GOMODCACHE"
    set -Ux GOMODCACHE $GOPATH/pkg/mod
end

if test -z "$GOEXPERIMENT"
    set -Ux GOEXPERIMENT rangefunc
end

fish_add_path -m $GOBIN
