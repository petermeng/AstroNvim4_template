return {
  {
    "folke/persistence.nvim",
    lazy = false,
    config = function()
      require("persistence").setup()
    end,
    keys = {
      { "<leader>is", mode = { "n" }, function() require("persistence").load() end, desc = "Load Session" },
      { "<leader>il", mode = { "n" }, function() require("persistence").load({ last = true }) end, desc = "Load Last Session" },
      { "<leader>id", mode = { "n" }, function() require("persistence").stop() end, desc = "Stop Session" },
    }
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
      require("window-picker").setup({
        filter_rules = {
            include_current_win = true,
            bo = {
                filetype = { "fidget", "neo-tree" }
            }
        }
      })
    vim.keymap.set("n",
                "<c-w>p",
                function()
                    local window_number = require('window-picker').pick_window()
                    if window_number then vim.api.nvim_set_current_win(window_number) end
                end
            )
    end
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
}
