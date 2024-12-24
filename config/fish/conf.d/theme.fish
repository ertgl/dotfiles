if status is-interactive
    setenv_prefers_color_scheme
end

function on_setenv_prefers_color_scheme --on-variable PREFERS_COLOR_SCHEME
    sketchybar_reload_theme $PREFERS_COLOR_SCHEME
    borders_reload_theme $PREFERS_COLOR_SCHEME
	nvim_reload_theme $PREFERS_COLOR_SCHEME
	tmux_reload_theme $PREFERS_COLOR_SCHEME
	alacritty_reload_theme $PREFERS_COLOR_SCHEME
end
