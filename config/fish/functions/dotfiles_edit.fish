function dotfiles_edit
    if not set -q DOTFILES_DIR
        echo "DOTFILES_DIR is not set"
        return 1
    end

    bash -c "(cd "$DOTFILES_DIR" && $EDITOR $argv)"
end
