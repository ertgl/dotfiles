if test -z "$XDG_CACHE_HOME"
    set -Ux XDG_CACHE_HOME ~/.cache
end

if test -z "$XDG_CACHE_DIR"
    set -Ux XDG_CACHE_DIR $XDG_CACHE_HOME
end

if test -z "$XDG_CONFIG_HOME"
    set -Ux XDG_CONFIG_HOME ~/.config
end

if test -z "$XDG_CONFIG_DIR"
    set -Ux XDG_CONFIG_DIR $XDG_CONFIG_HOME
end

if test -z "$XDG_DATA_HOME"
    set -Ux XDG_DATA_HOME ~/.local/share
end

if test -z "$XDG_DATA_DIR"
    set -Ux XDG_DATA_DIR $XDG_DATA_HOME
end

if test -z "$XDG_STATE_HOME"
    set -Ux XDG_STATE_HOME ~/.local/state
end

if test -z "$XDG_STATE_DIR"
    set -Ux XDG_STATE_DIR $XDG_STATE_HOME
end

fish_add_path -m ~/.local/bin

function on_set_XDG_CACHE_HOME --on-variable XDG_CACHE_HOME
    set -Ux XDG_CACHE_DIR $XDG_CACHE_HOME
end

function on_set_XDG_CONFIG_HOME --on-variable XDG_CONFIG_HOME
    set -Ux XDG_CONFIG_DIR $XDG_CONFIG_HOME
end

function on_set_XDG_DATA_HOME --on-variable XDG_DATA_HOME
    set -Ux XDG_DATA_DIR $XDG_DATA_HOME
end

function on_set_XDG_STATE_HOME --on-variable XDG_STATE_HOME
    set -Ux XDG_STATE_DIR $XDG_STATE_HOME
end
