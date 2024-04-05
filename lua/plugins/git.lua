return {
  {
    "f-person/git-blame.nvim",
    event = "User AstroGitFile",
  },
  {
    "sindrets/diffview.nvim",
    event = "User AstroGitFile",
    cmd = { "DiffviewOpen" },
  },
  {
		"kdheepak/lazygit.nvim",
		keys = { "<c-g>" },
		config = function()
			vim.g.lazygit_floating_window_scaling_factor = 1.0
			vim.g.lazygit_floating_window_winblend = 0
			vim.g.lazygit_use_neovim_remote = true
			vim.keymap.set("n", "<c-g>", ":LazyGit<CR>", { noremap = true, silent = true })
		end
	},
}
