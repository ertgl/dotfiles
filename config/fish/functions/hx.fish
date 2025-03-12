function hx --wraps=/usr/local/bin/hx
    env PATH=(string join ":" ~/.local/share/nvim/mason/bin $PATH) /usr/local/bin/hx $argv
end
