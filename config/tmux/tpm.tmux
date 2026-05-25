if-shell '! test -f ~/.tmux/plugins/tpm/tpm' {
  display-message "TPM is not installed."
} {
  if-shell '! command -v tmux &>/dev/null' {
    run-shell -E 'PATH="/opt/homebrew/bin:${PATH}" ~/.tmux/plugins/tpm/tpm'
  } {
    run-shell -E '~/.tmux/plugins/tpm/tpm'
  }
}
