function lulu_anonymize
    if not set -q DOTFILES_DIR
        echo "DOTFILES_DIR is not set" >&2
        return 1
    end

    if not test -d $DOTFILES_DIR
        echo "DOTFILES_DIR is not a directory" >&2
        return 2
    end

    set -l rules_file $DOTFILES_DIR/config/lulu/rules.json

    if not test -f $rules_file
        echo "Rules file does not exist: $rules_file" >&2
        return 3
    end

    set -l tmp_file (mktemp)
    lulu_datetime_anonymize <$rules_file >$tmp_file
    mv $tmp_file $rules_file
end
