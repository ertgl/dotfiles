if-shell '[ -n "$PREFERS_COLOR_SCHEME" ]' {
  set-option -g @prefers-color-scheme "$PREFERS_COLOR_SCHEME"
} {
  if-shell 'defaults read -g AppleInterfaceStyle &>/dev/null' {
    set-option -g @prefers-color-scheme dark
  } {
    set-option -g @prefers-color-scheme light
  }
}
