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
}
