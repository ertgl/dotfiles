function nvim_runtime_path
    nvim --clean --headless -c 'lua io.write(vim.env.VIMRUNTIME)' -c 'qa!'
end
