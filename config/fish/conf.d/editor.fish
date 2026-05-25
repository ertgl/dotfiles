if test -z "$EDITOR"
    set -Ux EDITOR nvim
end

if test -z "$VISUAL"
    set -Ux VISUAL 'code --wait'
end
