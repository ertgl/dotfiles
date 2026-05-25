function brew_bundle
    if not set -q DOTFILES_DIR
        echo "DOTFILES_DIR is not set"
        return 1
    end

    brew bundle --file=$DOTFILES_DIR/Brewfile
    rm -f $DOTFILES_DIR/Brewfile.lock.json
end
