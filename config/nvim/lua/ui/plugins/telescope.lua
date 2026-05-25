local M = {}

function M.get_pack_specs()
  return {
    {
      name = "telescope",
      src = "https://github.com/nvim-telescope/telescope.nvim",
      version = "7d324792b7943e4aa16ad007212e6acc6f9fe335",
    },
    {
      name = "telescope-fzf-native",
      src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
      version = "b25b749b9db64d375d782094e2b9dce53ad53a40",
    },
    {
      name = "telescope-ui-select",
      src = "https://github.com/nvim-telescope/telescope-ui-select.nvim",
      version = "6e51d7da30bd139a6950adf2a47fda6df9fa06d2",
    },
    {
      name = "telescope-undo",
      src = "https://github.com/debugloop/telescope-undo.nvim",
      version = "928d0c2dc9606e01e2cc547196f48d2eaecf58e5",
    },
  }
end

function M.setup_pack_autocmds()
  local handle_pack_changed = function(ev)
    if
      ev.data.spec.name == "telescope-fzf-native"
      and (ev.data.kind == "install" or ev.data.kind == "update")
    then
      vim.system({
        "make",
      }, {
        cwd = ev.data.path,
      })
    end
  end

  vim.api.nvim_create_autocmd("PackChanged", {
    callback = handle_pack_changed,
  })
end

function M.setup()
  if vim.g.vscode then
    return
  end

  local telescope = require("telescope")

  local borders = require("ui.borders")

  telescope.setup({
    defaults = {
      border = true,
      borderchars = {
        borders.top,
        borders.right,
        borders.bottom,
        borders.left,
        borders.top_left,
        borders.top_right,
        borders.bottom_right,
        borders.bottom_left,
      },
      color_devicons = false,
      disable_devicons = true,
      entry_prefix = "  ",
      layout_config = {
        height = 0.9,
        width = 0.9,
        prompt_position = "top",
      },
      preview_title = false,
      prompt_prefix = " ",
      prompt_title = false,
      results_title = false,
      selection_caret = "▌ ",
      sorting_strategy = "ascending",
    },
    pickers = {
      buffers = {
        layout_config = {
          preview_width = 0.5,
        },
      },
      find_files = {
        layout_config = {
          preview_width = 0.5,
        },
      },
      live_grep = {
        layout_config = {
          preview_width = 0.5,
        },
      },
    },
  })

  M.setup_telescope_fzf_native()
  M.setup_telescope_ui_select()
  M.setup_telescope_undo()

  M.setup_autocmds()
  M.setup_keymaps()
end

function M.setup_telescope_fzf_native()
  local telescope = require("telescope")

  telescope.setup({
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  })

  telescope.load_extension("fzf")
end

function M.setup_telescope_ui_select()
  local telescope = require("telescope")
  local telescope_themes = require("telescope.themes")

  telescope.setup({
    extensions = {
      ["ui-select"] = {
        telescope_themes.get_dropdown({}),
      },
    },
  })

  telescope.load_extension("ui-select")
end

function M.setup_telescope_undo()
  local telescope = require("telescope")

  telescope.setup({
    extensions = {
      undo = {
        entry_format = "State #$ID, $STAT, $TIME",
        layout_config = {
          preview_width = 0.8,
        },
        layout_strategy = "horizontal",
        side_by_side = false,
        use_delta = true,
      },
    },
  })

  telescope.load_extension("undo")

  vim.keymap.set("n", "<leader>ut", function()
    telescope.extensions.undo.undo()
  end, {
    desc = "Open undo tree",
  })

  vim.keymap.set("n", "<leader>uu", function()
    telescope.extensions.undo.undo()
  end, {
    desc = "Open undo tree",
  })
end

function M.setup_autocmds()
  vim.api.nvim_create_autocmd("WinLeave", {
    callback = function()
      if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
        vim.api.nvim_feedkeys(
          vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
          "i",
          false
        )
      end
    end,
  })
end

function M.setup_keymaps()
  local telescope_builtin = require("telescope.builtin")
  local telescope_utils = require("telescope.utils")

  vim.keymap.set("n", "<c-p>", telescope_builtin.commands, {
    desc = "List commands",
  })

  local generate_find_command = function(opts)
    local cwd = opts.cwd
    if not cwd then
      cwd = vim.fn.getcwd()
    end

    local cmd = {
      "fd",
      "--type",
      "file",
      "--hidden",
      "--no-follow",
      "--no-require-git",
    }

    if opts.buffer_relative then
      table.insert(cmd, "--base-directory")
      table.insert(cmd, telescope_utils.buffer_dir())
    else
      table.insert(cmd, "--base-directory")
      table.insert(cmd, cwd)
    end

    if opts.no_ignore then
      table.insert(cmd, "--no-ignore")
      table.insert(cmd, "--no-ignore-parent")
      table.insert(cmd, "--no-ignore-vcs")
    else
      table.insert(cmd, "--exclude")
      table.insert(cmd, ".git")
      table.insert(cmd, "--ignore")
      table.insert(cmd, "--ignore-vcs")
    end

    return cmd
  end

  vim.keymap.set("n", "<leader>ff", function()
    local cwd = vim.fn.getcwd()

    telescope_builtin.find_files({
      cwd = cwd,
      find_command = generate_find_command({
        buffer_relative = false,
        cwd = cwd,
        no_ignore = false,
      }),
      follow = true,
      hidden = true,
      no_ignore = false,
      no_ignore_parent = false,
    })
  end, {
    desc = "Open file picker",
  })

  vim.keymap.set("n", "<leader>fF", function()
    local cwd = vim.fn.getcwd()

    telescope_builtin.find_files({
      cwd = cwd,
      find_command = generate_find_command({
        buffer_relative = false,
        cwd = cwd,
        no_ignore = true,
      }),
      follow = true,
      hidden = true,
      no_ignore = true,
      no_ignore_parent = true,
    })
  end, {
    desc = "Open file picker (No ignore)",
  })

  vim.keymap.set("n", "<leader>fd", function()
    local buffer_dir = telescope_utils.buffer_dir()

    telescope_builtin.find_files({
      cwd = buffer_dir,
      find_command = generate_find_command({
        buffer_relative = true,
        cwd = buffer_dir,
        no_ignore = false,
      }),
      follow = true,
      hidden = true,
      no_ignore = false,
      no_ignore_parent = false,
    })
  end, {
    desc = "Open file picker in current buffer directory",
  })

  vim.keymap.set("n", "<leader>fD", function()
    local buffer_dir = telescope_utils.buffer_dir()

    telescope_builtin.find_files({
      cwd = buffer_dir,
      find_command = generate_find_command({
        buffer_relative = true,
        cwd = buffer_dir,
        no_ignore = true,
      }),
      follow = true,
      hidden = true,
      no_ignore = true,
      no_ignore_parent = true,
    })
  end, {
    desc = "Open file picker in current buffer directory (No ignore)",
  })

  vim.keymap.set("n", "<leader>fo", function()
    telescope_builtin.oldfiles({
      cwd = vim.fn.getcwd(),
      hidden = true,
      no_ignore = false,
      no_ignore_parent = false,
    })
  end, {
    desc = "List old files",
  })

  vim.keymap.set("n", "<leader>fO", function()
    telescope_builtin.oldfiles({
      cwd = vim.fn.getcwd(),
      hidden = true,
      no_ignore = true,
      no_ignore_parent = true,
    })
  end, {
    desc = "List old files (No ignore)",
  })

  vim.keymap.set("n", "<leader>fg", function()
    telescope_builtin.live_grep({
      cwd = vim.fn.getcwd(),
      hidden = true,
      no_ignore = false,
      no_ignore_parent = false,
    })
  end, {
    desc = "Search in files",
  })

  vim.keymap.set("n", "<leader>fG", function()
    telescope_builtin.live_grep({
      cwd = vim.fn.getcwd(),
      hidden = true,
      no_ignore = true,
      no_ignore_parent = true,
    })
  end, {
    desc = "Search in files (No ignore)",
  })

  vim.keymap.set("n", "<leader>bl", function()
    telescope_builtin.buffers({
      cwd = vim.fn.getcwd(),
      cwd_only = true,
      ignore_current_buffer = true,
      select_current = false,
      show_all_buffers = false,
      sort_mru = true,
    })
  end, {
    desc = "List buffers (Current working directory)",
  })

  vim.keymap.set("n", "<leader>fb", function()
    telescope_builtin.buffers({
      cwd = vim.fn.getcwd(),
      cwd_only = true,
      ignore_current_buffer = true,
      select_current = false,
      show_all_buffers = false,
      sort_mru = true,
    })
  end, {
    desc = "List buffers (Current working directory)",
  })

  vim.keymap.set("n", "<leader>bL", function()
    telescope_builtin.buffers({
      ignore_current_buffer = true,
      cwd_only = false,
      select_current = false,
      show_all_buffers = true,
      sort_mru = true,
    })
  end, {
    desc = "List buffers (All)",
  })

  vim.keymap.set("n", "<leader>fB", function()
    telescope_builtin.buffers({
      ignore_current_buffer = true,
      cwd_only = false,
      select_current = false,
      show_all_buffers = true,
      sort_mru = true,
    })
  end, {
    desc = "List buffers (All)",
  })

  vim.keymap.set("n", "<leader>sh", function()
    telescope_builtin.search_history()
  end, {
    desc = "List search history",
  })

  vim.keymap.set("n", "<leader>pr", function()
    telescope_builtin.resume()
  end, {
    desc = "Resume last picker",
  })

  vim.keymap.set("n", "<leader>fM", telescope_builtin.marks, { desc = "List marks" })

  vim.keymap.set("n", "<leader>hc", telescope_builtin.commands, { desc = "List commands" })
  vim.keymap.set("n", "<leader>hh", telescope_builtin.help_tags, { desc = "List help tags" })
  vim.keymap.set("n", "<leader>hm", telescope_builtin.man_pages, { desc = "List man pages" })

  vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", {
    buffer = true,
    desc = "Go to definitions",
  })

  -- vim.keymap.set("n", "gri", "<cmd>Telescope lsp_implementations<cr>", {
  --   buffer = true,
  --   desc = "Go to implementation",
  -- })

  vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", {
    buffer = true,
    desc = "Go to implementations",
  })

  -- vim.keymap.set("n", "grr", "<cmd>Telescope lsp_references<cr>", {
  --   buffer = true,
  --   desc = "Go to references",
  -- })

  vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", {
    buffer = true,
    desc = "Go to references",
  })

  -- vim.keymap.set("n", "grt", "<cmd>Telescope lsp_type_definitions<cr>", {
  --   buffer = true,
  --   desc = "Go to type definitions",
  -- })

  vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", {
    buffer = true,
    desc = "Go to type definitions",
  })
end

return M
