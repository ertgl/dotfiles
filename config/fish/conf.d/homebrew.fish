if test -z "$HOMEBREW_BUNDLE_FILE_GLOBAL"
    if test -z "$XDG_CONFIG_HOME"
        set -Ux HOMEBREW_BUNDLE_FILE_GLOBAL ~/.config/homebrew/Brewfile
    else
        set -Ux HOMEBREW_BUNDLE_FILE_GLOBAL $XDG_CONFIG_HOME/homebrew/Brewfile
    end
end

if test -z "$HOMEBREW_NO_ANALYTICS"
    set -Ux HOMEBREW_NO_ANALYTICS 1
end

if test -z "$HOMEBREW_NO_AUTO_UPDATE"
    set -Ux HOMEBREW_NO_AUTO_UPDATE 1
end

if test -z "$HOMEBREW_NO_INSTALL_CLEANUP"
    set -Ux HOMEBREW_NO_INSTALL_CLEANUP 1
end
