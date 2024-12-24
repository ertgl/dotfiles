if test -z "$BAT_STYLE"
    set -Ux BAT_STYLE plain
end

if test -z "$BAT_THEME_DARK"
    set -Ux BAT_THEME_DARK gruvbox-dark
end

if test -z "$BAT_THEME_LIGHT"
    set -Ux BAT_THEME_LIGHT gruvbox-light
end

alias batd "bat --style=default"
