return {
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    pylsp = {
      plugins = {
        jedi_completion = {
          include_class_objects = true,
          include_function_objects = true,
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
          code_actions = {
            enabled = true,
          },
          completions = {
            enabled = true,
          },
        },
        rope_completion = {
          enabled = true,
        },
      },
      signature = {
        formatter = "ruff",
      },
    },
  },
}
