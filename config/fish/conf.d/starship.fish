if test -z "$STARSHIP_CONFIG"
    set -Ux STARSHIP_CONFIG ~/.config/starship/starship.toml
end

if status is-interactive
    starship init fish | source
end
