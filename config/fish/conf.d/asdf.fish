if test -z "$ASDF_DATA_DIR"
    set -Ux ASDF_DATA_DIR $HOME/.asdf
end

set -gx --prepend PATH "$ASDF_DATA_DIR/shims"
