if test -z "$ASDF_DATA_DIR"
    set -Ux ASDF_DATA_DIR $HOME/.asdf
end

fish_add_path --move --path --prepend "$ASDF_DATA_DIR/shims"
