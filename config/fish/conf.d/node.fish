if test -z "$NODE_PATH"
    set -Ux NODE_PATH (npm root --quiet -g)
end
