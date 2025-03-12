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

function on_setenv_prefers_color_scheme_reload_bat_theme --on-event theme_reload_phase_4
    if test -z "$PREFERS_COLOR_SCHEME"
        return 0
    end

    bat_reload_theme $PREFERS_COLOR_SCHEME
end
