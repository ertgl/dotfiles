if test -z "$GOPATH"
    set -Ux GOPATH ~/Code
end

if test -z "$GOBIN"
    set -Ux GOBIN $GOPATH/bin
end

if test -z "$GOMODCACHE"
    set -Ux GOMODCACHE $GOPATH/pkg/mod
end

if test -z "$GOEXPERIMENT"
    set -Ux GOEXPERIMENT ""
end

fish_add_path -m $GOBIN
