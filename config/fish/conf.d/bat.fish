if test -z "$BAT_STYLE"
    set -Ux BAT_STYLE plain
end

if test -z "$BAT_THEME_DARK"
    set -Ux BAT_THEME_DARK gruvbox-dark
end

if test -z "$BAT_THEME_LIGHT"
    set -Ux BAT_THEME_LIGHT gruvbox-light
end

if status is-interactive && test -z "$BAT_THEME"
    bat_reload_theme
end

function handle_theme_reload_for_bat --on-variable LAST_COLOR_SCHEME
    if test -z "$LAST_COLOR_SCHEME"
        return 0
    end

    bat_reload_theme $LAST_COLOR_SCHEME
end
