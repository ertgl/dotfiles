if status is-interactive
    if test -z "$PREFERS_COLOR_SCHEME"
        setenv_prefers_color_scheme
    end

    if test -z "$INHERIT_SYSTEM_THEME"
        theme_gruvbox "$PREFERS_COLOR_SCHEME" hard
    end
end

function handle_theme_reload --on-variable LAST_COLOR_SCHEME
    if test -z "$LAST_COLOR_SCHEME"
        return 0
    end

    if test -z "$INHERIT_SYSTEM_THEME"
        theme_gruvbox "$LAST_COLOR_SCHEME" hard
    end
end
