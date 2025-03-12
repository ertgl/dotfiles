if test -z "$FZF_DEFAULT_COMMAND"
    set -Ux FZF_DEFAULT_COMMAND ""
end

if test -z "$FZF_DEFAULT_OPTS"
    set -Ux FZF_DEFAULT_OPTS --tmux 90%,90%,border-native
end

if test -z "$FZF_CTRL_T_COMMAND"
    set -Ux FZF_CTRL_T_COMMAND ''
end

if test -z "$FZF_ALT_C_COMMAND"
    set -Ux FZF_ALT_C_COMMAND ''
end
