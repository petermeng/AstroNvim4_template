return {
  {
    "folke/persistence.nvim",
    lazy = false,
    config = function() require("persistence").setup() end,
    keys = {
      { "<leader>is", mode = { "n" }, function() require("persistence").load() end, desc = "Load Session" },
      {
        "<leader>il",
        mode = { "n" },
        function() require("persistence").load { last = true } end,
        desc = "Load Last Session",
      },
      { "<leader>id", mode = { "n" }, function() require("persistence").stop() end, desc = "Stop Session" },
    },
  },
  {
    "ellisonleao/glow.nvim",
    config = true,
    cmd = "Glow",
  },
  {
    "s1n7ax/nvim-window-picker",
    lazy = false,
    config = function()
      require("window-picker").setup {
        filter_rules = {
          include_current_win = true,
          bo = {
            filetype = { "fidget", "neo-tree" },
          },
        },
      }
      vim.keymap.set("n", "<c-w>p", function()
        local window_number = require("window-picker").pick_window()
        if window_number then vim.api.nvim_set_current_win(window_number) end
      end)
    end,
  },
  {
    "tris203/precognition.nvim",
    event = "VeryLazy",
    opts = {
      startVisible = true,
      showBlankVirtLine = true,
      highlightColor = { link = "Comment" },
      hints = {
        Caret = { text = "^", prio = 2 },
        Dollar = { text = "$", prio = 1 },
        MatchingPair = { text = "%", prio = 5 },
        Zero = { text = "0", prio = 1 },
        w = { text = "w", prio = 10 },
        b = { text = "b", prio = 9 },
        e = { text = "e", prio = 8 },
        W = { text = "W", prio = 7 },
        B = { text = "B", prio = 6 },
        E = { text = "E", prio = 5 },
      },
      gutterHints = {
        G = { text = "G", prio = 10 },
        gg = { text = "gg", prio = 9 },
        PrevParagraph = { text = "{", prio = 8 },
        NextParagraph = { text = "}", prio = 8 },
      },
    },
  },
  {
    "tris203/hawtkeys.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = {
      -- an empty table will work for default config
      --- if you use functions, or whichkey, or lazy to map keys
      --- then please see the API below for options
    },
  },
  {
    "yorickpeterse/nvim-window",
    keys = {
      { "<leader>wj", "<cmd>lua require('nvim-window').pick()<cr>", desc = "nvim-window: Jump to window" },
    },
    config = true,
  },
  {
    "FeiyouG/commander.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("commander").add {
        {
          desc = "Open commander",
          cmd = require("commander").show,
          keys = { "n", "<Leader>fO" },
        },
      }
    end,
  },
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      -- 👇 in this section, choose your own keymappings!
      {
        "<leader>-",
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        -- Open in the current working directory
        "<leader>rY",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
      {
        -- NOTE: this requires a version of yazi that includes
        -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
        "<c-up>",
        "<cmd>Yazi toggle<cr>",
        desc = "Resume the last yazi session",
      },
    },
    ---@type YaziConfig
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = "<f1>",
      },
    },
  },
  -- Lazy
  {
    "2kabhishek/tdo.nvim",
    dependencies = "2kabhishek/pickme.nvim",
    cmd = { "Tdo" },
    keys = { "<leader>nn", "<leader>nt", "<leader>nx", "[t", "]t" }, -- Add more keybindings you need for lazy loading
    config = function()
      local tdo = require "tdo"
      tdo.setup {
        add_default_keybindings = true, -- Add default keybindings for the plugin
        completion = {
          offsets = {}, -- Custom offsets / date expressions for completion
          ignored_files = { "README.md", "templates" }, -- Files/directories to ignore in completions
        },
        cache = { -- You don't really need to change these
          timeout = 5000, -- Completion cache timeout in milliseconds
          max_entries = 100, -- Maximum number of cached completion entries
        },
        lualine = { -- Only used for lualine integration
          update_frequency = 300, -- How frequently to update the pending todo count in lualine
          only_show_in_notes = false, -- Whether to show the lualine component only in notes buffers
        },
      }
    end,
  },
  {
    "2kabhishek/markit.nvim",
    dependencies = { "2kabhishek/pickme.nvim" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("markit").setup {
        -- whether to add comprehensive default keybindings. default true
        add_default_keybindings = true,
        -- which builtin marks to show. default {}
        builtin_marks = { ".", "<", ">", "^" },
        -- whether movements cycle back to the beginning/end of buffer. default true
        cyclic = true,
        -- whether the shada file is updated after modifying uppercase marks. default false
        force_write_shada = false,
        -- how often (in ms) to redraw signs/recompute mark positions.
        -- higher value means better performance but may cause visual lag,
        -- while lower value may cause performance penalties. default 150.
        refresh_interval = 150,
        -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
        -- marks, and bookmarks.
        -- can be either a table with all/none of the keys, or a single number, in which case
        -- the priority applies to all marks.
        -- default 10.
        sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
        -- disables mark tracking for specific filetypes. default {}
        excluded_filetypes = {},
        -- disables mark tracking for specific buftypes. default {}
        excluded_buftypes = {},
        -- bookmark groups configuration
        bookmarks = {
          {
            sign = "⚑", -- string: sign character to display (empty string to disable)
            virt_text = "hello", -- string: virtual text to show at end of line
            annotate = false, -- boolean: whether to prompt for annotation when setting bookmark
          },
          { sign = "!", virt_text = "", annotate = false },
          { sign = "@", virt_text = "", annotate = true },
        },
      }
    end,
  },
}
