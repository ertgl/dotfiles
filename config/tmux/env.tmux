set -ga update-environment TERM
set -ga update-environment TERM_PROGRAM

if '[ -z "$PREFERS_COLOR_SCHEME" ]' {
    setenv -g PREFERS_COLOR_SCHEME 'dark'
}
