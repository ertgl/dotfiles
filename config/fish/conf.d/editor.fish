if test -z "$EDITOR"
    set -Ux EDITOR vi
end

if test -z "$VISUAL"
    set -Ux VISUAL 'code --wait'
end
