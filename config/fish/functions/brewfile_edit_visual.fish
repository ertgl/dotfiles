function brewfile_edit_visual
    if test -z "$VISUAL"
        set VISUAL code
    end

    eval "$VISUAL $DOTFILES_DIR/Brewfile"
end
