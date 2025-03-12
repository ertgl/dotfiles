function vscode_backup_extensions
    if not set -q DOTFILES_DIR
        echo "DOTFILES_DIR is not set"
        return 1
    end

    if not test -d $DOTFILES_DIR
        echo "DOTFILES_DIR is not a directory"
        return 2
    end

    set -lu vscode_config_dir $DOTFILES_DIR/config/vscode
    set -lu vscode_profile (whoami)

    mkdir -p $vscode_config_dir

    code --profile $vscode_profile --list-extensions | sort >$vscode_config_dir/extensions.txt
end
