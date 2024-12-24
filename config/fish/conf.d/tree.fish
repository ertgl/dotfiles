alias _tree "/usr/local/bin/tree --dirsfirst"

if status is-interactive
    alias tree "_tree -C"
else
    alias tree _tree
end
