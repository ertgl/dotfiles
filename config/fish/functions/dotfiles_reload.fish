function dotfiles_reload
    if not set -q DOTFILES_DIR
        echo "DOTFILES_DIR is not set"
        return 1
    end

    fish_subst "cd $DOTFILES_DIR; and bash entrypoint.sh $argv"
end
