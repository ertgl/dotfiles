# if not type -q code
#     alias code code-insiders
# end

string match -q "$TERM_PROGRAM" "vscode"
  and . (code --locate-shell-integration-path fish)
