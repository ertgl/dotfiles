function dotfiles_push
    if not set -q DOTFILES_DIR
        echo "DOTFILES_DIR is not set"
        return 1
    end

    bash -c '(cd -- "$DOTFILES_DIR" && git add -A && git commit --amend -m "chore: sync" && git push --force)'
end
