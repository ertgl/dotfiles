if-shell '! command -v tmux &>/dev/null' {
  if-shell '[[ ":${PATH}:" != *":/opt/homebrew/bin:"* ]]' {
    set-option -ga update-environment PATH
    set-environment -gF PATH "/opt/homebrew/bin:${PATH}"
  }
}

set-option -ga update-environment PREFERS_COLOR_SCHEME
set-environment -gF PREFERS_COLOR_SCHEME "#{@prefers-color-scheme}"

set-option -ga update-environment TERM
set-option -ga update-environment TERM_PROGRAM

set-environment -g TMUX_PLUGIN_MANAGER_PATH "~/.tmux/plugins"
