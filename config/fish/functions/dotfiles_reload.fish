function dotfiles_reload
    if not set -q DOTFILES_DIR
        echo "DOTFILES_DIR is not set" >&2
        return 1
    end

    bash -c "(cd -- "$DOTFILES_DIR" && bash bin/dotfiles_reload.sh $argv)"
end
