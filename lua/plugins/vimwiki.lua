return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "vimwiki/vimwiki",
      "ElPiloto/telescope-vimwiki.nvim",
    },
    config = function()
      require("telescope").load_extension("vimwiki")
      -- optional: vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
    end,
  },
}
