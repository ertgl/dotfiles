return {
  {
    "nvim-telescope/telescope.nvim",
    cond = not (vim.g.nvcat or vim.g.vscode),
    lazy = false,
    config = function()
      local telescope = require("telescope")
      local telescope_builtin = require("telescope.builtin")
      local telescope_utils = require("telescope.utils")

      local borders = require("config.borders")

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
        local cwd = telescope_utils.buffer_dir()

        telescope_builtin.find_files({
          cwd = cwd,
          find_command = generate_find_command({
            buffer_relative = true,
            cwd = cwd,
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
        local cwd = telescope_utils.buffer_dir()

        telescope_builtin.find_files({
          cwd = cwd,
          find_command = generate_find_command({
            buffer_relative = true,
            cwd = cwd,
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

      vim.api.nvim_create_autocmd("WinLeave", {
        callback = function()
          if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
          end
        end,
      })
    end,
  },

  {
    "nvim-telescope/telescope-frecency.nvim",
    cond = not (vim.g.nvcat or vim.g.vscode),
    event = "VeryLazy",
    config = function()
      local telescope = require("telescope")

      telescope.load_extension("frecency")
    end,
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    cond = not (vim.g.nvcat or vim.g.vscode),
    build = "make",
    config = function()
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
    end,
  },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    cond = not (vim.g.nvcat or vim.g.vscode),
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local telescope_utils = require("telescope.utils")

      telescope.setup({
        extensions = {
          file_browser = {
            cwd = vim.fn.getcwd(),
            cwd_to_path = true,
            follow_symlinks = true,
            grouped = true,
            hidden = true,
            hide_parent_dir = true,
            hijack_netrw = false,
            no_ignore = true,
            prompt_path = true,
            respect_gitignore = false,
            select_buffer = true,
            use_fd = true,
          },
        },
      })

      telescope.load_extension("file_browser")

      vim.keymap.set("n", "<leader>fpd", function()
        telescope.extensions.file_browser.file_browser({
          path = telescope_utils.buffer_dir(),
        })
      end, {
        desc = "Open file browser in current buffer directory",
      })

      vim.keymap.set("n", "<leader>fpf", telescope.extensions.file_browser.file_browser, {
        desc = "Open file browser in current working directory",
      })
    end,
  },

  {
    "debugloop/telescope-undo.nvim",
    cond = not (vim.g.nvcat or vim.g.vscode),
    lazy = false,
    config = function()
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
    end,
  },

  {
    "nvim-telescope/telescope-ui-select.nvim",
    cond = not (vim.g.nvcat or vim.g.vscode),
    lazy = false,
    config = function()
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
    end,
  },
}
