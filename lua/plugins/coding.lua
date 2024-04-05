return {
  {
    "dhananjaylatkar/cscope_maps.nvim",
    lazy = false,
    dependencies = {
      "folke/which-key.nvim", -- optional [for whichkey hints]
      "nvim-telescope/telescope.nvim", -- optional [for picker="telescope"]
      "ibhagwan/fzf-lua", -- optional [for picker="fzf-lua"]
      "nvim-tree/nvim-web-devicons", -- optional [for devicons in telescope or fzf]
    },
    opts = {
      -- USE EMPTY FOR DEFAULT OPTIONS
      -- DEFAULTS ARE LISTED BELOW
      cscope = {
        -- choose your fav picker
        picker = "fzf-lua", -- "telescope", "fzf-lua" or "quickfix"
      },
    },
  },
  {
    "preservim/tagbar",
    lazy = false,
    config = function()
      local wk_avail, wk = pcall(require, "which-key")
      if wk_avail then
        wk.register {
          ["<leader>T"] = {
            name = "TagBar",
            t = { "<cmd>TagbarToggle<CR>", "Tagbar toggle" },
          },
        }
      end
    end,
  },
  {
    "rmagatti/goto-preview",
    event = "User AstroFile",
    config = function()
      require("goto-preview").setup {
        width = 120, -- Width of the floating window
        height = 15, -- Height of the floating window
        border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" }, -- Border characters of the floating window
        default_mappings = false, -- Bind default mappings
        debug = false, -- Print debug information
        opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
        resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
        post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
        post_close_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
        references = { -- Configure the telescope UI for slowing the references cycling window.
          telescope = require("telescope.themes").get_dropdown { hide_preview = false },
        },
        -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
        focus_on_open = true, -- Focus the floating window when opening it.
        dismiss_on_move = false, -- Dismiss the floating window when moving the cursor.
        force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
        bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
        stack_floating_preview_windows = true, -- Whether to nest floating windows
        preview_window_title = { enable = true, position = "left" }, -- Whether to set the preview window title as the filename
      }
      local wk_avail, wk = pcall(require, "which-key")
      if wk_avail then
        wk.register {
          ["<Leader>G"] = {
            name = "GotoPreview",
            pd = { "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", "Preview definition" },
            pt = { "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", "Preview Type definition" },
            pi = { "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", "Implementation" },
            P = { "<cmd>lua require('goto-preview').close_all_win()<CR>", "Close all windows" },
            pr = { "<cmd>lua require('goto-preview').goto_preview_references()<CR>", "References" },
          },
        }
      end
    end,
  },
  {
    "dnlhc/glance.nvim",
    event = "User AstroFile",
    -- enabled = false,
    config = function()
      local glance = require "glance"
      local actions = glance.actions

      glance.setup {
        height = 18, -- Height of the window
        zindex = 45,

        -- By default glance will open preview "embedded" within your active window
        -- when `detached` is enabled, glance will render above all existing windows
        -- and won't be restiricted by the width of your active window
        detached = true,

        -- Or use a function to enable `detached` only when the active window is too small
        -- (default behavior)
        detached = function(winid) return vim.api.nvim_win_get_width(winid) < 100 end,

        preview_win_opts = { -- Configure preview window options
          cursorline = true,
          number = true,
          wrap = true,
        },
        border = {
          enable = false, -- Show window borders. Only horizontal borders allowed
          top_char = "―",
          bottom_char = "―",
        },
        list = {
          position = "right", -- Position of the list window 'left'|'right'
          width = 0.33, -- 33% width relative to the active window, min 0.1, max 0.5
        },
        theme = { -- This feature might not work properly in nvim-0.7.2
          enable = true, -- Will generate colors for the plugin based on your current colorscheme
          mode = "auto", -- 'brighten'|'darken'|'auto', 'auto' will set mode based on the brightness of your colorscheme
        },
        mappings = {
          list = {
            ["j"] = actions.next, -- Bring the cursor to the next item in the list
            ["k"] = actions.previous, -- Bring the cursor to the previous item in the list
            ["<Down>"] = actions.next,
            ["<Up>"] = actions.previous,
            ["<Tab>"] = actions.next_location, -- Bring the cursor to the next location skipping groups in the list
            ["<S-Tab>"] = actions.previous_location, -- Bring the cursor to the previous location skipping groups in the list
            ["<C-u>"] = actions.preview_scroll_win(5),
            ["<C-d>"] = actions.preview_scroll_win(-5),
            ["v"] = actions.jump_vsplit,
            ["s"] = actions.jump_split,
            ["t"] = actions.jump_tab,
            ["<CR>"] = actions.jump,
            ["o"] = actions.jump,
            ["l"] = actions.open_fold,
            ["h"] = actions.close_fold,
            ["<leader>l"] = actions.enter_win "preview", -- Focus preview window
            ["q"] = actions.close,
            ["Q"] = actions.close,
            ["<Esc>"] = actions.close,
            ["<C-q>"] = actions.quickfix,
            -- ['<Esc>'] = false -- disable a mapping
          },
          preview = {
            ["Q"] = actions.close,
            ["<Tab>"] = actions.next_location,
            ["<S-Tab>"] = actions.previous_location,
            ["<leader>l"] = actions.enter_win "list", -- Focus list window
          },
        },
        hooks = {},
        folds = {
          fold_closed = "",
          fold_open = "",
          folded = true, -- Automatically fold list on startup
        },
        indent_lines = {
          enable = true,
          icon = "│",
        },
        winbar = {
          enable = true, -- Available strating from nvim-0.8+
        },
      }
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      local telescope = require "telescope"
      local telescopeConfig = require "telescope.config"

      -- Clone the default Telescope configuration
      local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

      -- I want to search in hidden/dot files.
      table.insert(vimgrep_arguments, "--hidden")
      -- I don't want to search in the `.git` directory.
      table.insert(vimgrep_arguments, "--glob")
      table.insert(vimgrep_arguments, "!**/.git/*")
      table.insert(vimgrep_arguments, "!**/build/*")
    end,
    opts = function()
      local actions = require "telescope.actions"
      local get_icon = require("astroui").get_icon
      return {
        defaults = {
          git_worktrees = vim.g.git_worktrees,
          prompt_prefix = get_icon("Selected", 1),
          selection_caret = get_icon("Selected", 1),
          path_display = { "truncate" },
          sorting_strategy = "ascending",
          previewer = false,
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
            vertical = { mirror = false },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<RightMouse>"] = actions.close,
              ["<LeftMouse>"] = actions.select_default,
              ["<ScrollWheelDown>"] = actions.move_selection_next,
              ["<ScrollWheelUp>"] = actions.move_selection_previous,
            },
            n = { q = actions.close },
          },
        },
      }
    end,
  },
  {
    "fdschmidt93/telescope-egrepify.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      local egrep_actions = require "telescope._extensions.egrepify.actions"

      require("telescope").setup {
        extensions = {
          egrepify = {
            -- intersect tokens in prompt ala "str1.*str2" that ONLY matches
            -- if str1 and str2 are consecutively in line with anything in between (wildcard)
            AND = true, -- default
            permutations = false, -- opt-in to imply AND & match all permutations of prompt tokens
            lnum = true, -- default, not required
            lnum_hl = "EgrepifyLnum", -- default, not required, links to `Constant`
            col = false, -- default, not required
            col_hl = "EgrepifyCol", -- default, not required, links to `Constant`
            title = true, -- default, not required, show filename as title rather than inline
            filename_hl = "EgrepifyFile", -- default, not required, links to `Title`
            -- suffix = long line, see screenshot
            -- EXAMPLE ON HOW TO ADD PREFIX!
            prefixes = {
              -- ADDED ! to invert matches
              -- example prompt: ! sorter
              -- matches all lines that do not comprise sorter
              -- rg --invert-match -- sorter
              ["!"] = {
                flag = "invert-match",
              },
              -- HOW TO OPT OUT OF PREFIX
              -- ^ is not a default prefix and safe example
              ["^"] = false,
            },
            -- default mappings
            mappings = {
              i = {
                -- toggle prefixes, prefixes is default
                ["<C-z>"] = egrep_actions.toggle_prefixes,
                -- toggle AND, AND is default, AND matches tokens and any chars in between
                ["<C-a>"] = egrep_actions.toggle_and,
                -- toggle permutations, permutations of tokens is opt-in
                ["<C-r>"] = egrep_actions.toggle_permutations,
              },
            },
          },
        },
      }
      require("telescope").load_extension "egrepify"
    end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    event = "User AstroFile",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup {
        -- prompt for return type
        prompt_func_return_type = {
          go = true,
          cpp = true,
          c = true,
          java = true,
        },
        -- prompt for function parameters
        prompt_func_param_type = {
          go = true,
          cpp = true,
          c = true,
          java = true,
        },
      }
      vim.keymap.set({ "n", "x" }, "<leader>rt", function() require("telescope").extensions.refactoring.refactors() end)
      local wk_avail, wk = pcall(require, "which-key")
      if wk_avail then
        wk.register {
          ["<Leader>R"] = {
            name = "Refactoring",
            e = { function() require("refactoring").refactor "Extract Function" end, "Extract Function", mode = "x" },
            f = {
              function() require("refactoring").refactor "Extract Function To File" end,
              "Extract Function To File",
              mode = "x",
            },
            v = { function() require("refactoring").refactor "Extract Variable" end, "Extract Variable", mode = "x" },
            i = {
              function() require("refactoring").refactor "Inline Variable" end,
              "Inline Variable",
              mode = { "x", "n" },
            },
            b = { function() require("refactoring").refactor "Extract Block" end, "Extract Variable", mode = "n" },
            bf = {
              function() require("refactoring").refactor "Extract Block To File" end,
              "Extract Variable To File",
              mode = "n",
            },
            r = {
              function() require("telescope").extensions.refactoring.refactors() end,
              "Telescope",
              mode = { "n", "x" },
            },
          },
        }
      end
    end,
  },
  {
    "daishengdong/calltree.nvim",
    event = "User AstroFile",
    dependencies = {
      "dhananjaylatkar/cscope_maps.nvim",
      "folke/which-key.nvim", -- optional [for whichkey hints]
    },
    opts = {
      -- USE EMPTY FOR DEFAULT OPTIONS
      -- DEFAULTS ARE LISTED BELOW
      prefix = "<leader>O", -- keep consistent with cscope_maps
      tree_style = "brief", -- alternatives: detailed, detailed_paths
    },
  },
  {
    "leosmaia21/gcompilecommands.nvim",
    opts = {
      tmp_file_path = "$HOME/tmp/compilecommandsNEOVIM.json",
    },
    ft = { "c", "cpp" }, -- lazy load plugin only on C and C++ filetypes
  },
}
