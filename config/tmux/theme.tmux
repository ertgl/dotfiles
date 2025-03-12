if-shell '[ -n "$PREFERS_COLOR_SCHEME" ]' {
    run 'tmux setenv -g PREFERS_COLOR_SCHEME $PREFERS_COLOR_SCHEME'
}
