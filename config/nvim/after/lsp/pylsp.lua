return {
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    pylsp = {
      plugins = {
        jedi_completion = {
          fuzzy = true,
        },
        pycodestyle = {
          enabled = false,
        },
        pyflakes = {
          enabled = false,
        },
        rope_autoimport = {
          enabled = true,
        },
        rope_completion = {
          enabled = true,
        },
      },
    },
  },
}
