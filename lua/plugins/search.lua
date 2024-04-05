return {
  {
    "kevinhwang91/nvim-hlslens",
    config = function()
      require("hlslens").setup()
      local kopts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap(
        "n",
        "=",
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap(
        "n",
        "-",
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "<Leader><CR>", "<Cmd>noh<CR>", kopts)
    end,
  },
  {
    "pechorin/any-jump.vim",
    enabled = false,
    config = function()
      vim.keymap.set("n", "j", ":AnyJump<CR>", { noremap = true })
      vim.keymap.set("x", "j", ":AnyJumpVisual<CR>", { noremap = true })
      vim.g.any_jump_disable_default_keybindings = true
      vim.g.any_jump_window_width_ratio = 0.9
      vim.g.any_jump_window_height_ratio = 0.9
    end,
  },
  {
    "linrongbin16/fzfx.nvim",
    event = { CmdlineEnter },
    cmd = {
      "FzfxLspDefinitions",
      "FzfxLspTypeDefinitions",
      "FzfxLspReferences",
      "FzfxLspImplementations",
    },
    dependencies = { "junegunn/fzf" },
    config = function()
      require("fzfx").setup {
        popup = {
          win_opts = {
            height = 0.8,
            width = 0.8,
          },
        },
      }
      local wk_avail, wk = pcall(require, "which-key")
      if wk_avail then wk.register {
        ["<Leader>F"] = {
          name = "Fzfx Search",
        },
      } end
      -- ======== files ========

      -- find files
      vim.keymap.set("n", "<leader>Ff", "<cmd>FzfxFiles<cr>", { silent = true, noremap = true, desc = "Find files" })
      -- by visual select
      vim.keymap.set("x", "<leader>Ff", "<cmd>FzfxFilesV<CR>", { silent = true, noremap = true, desc = "Find files" })
      -- by cursor word
      vim.keymap.set(
        "n",
        "<leader>Fwf",
        "<cmd>FzfxFilesW<cr>",
        { silent = true, noremap = true, desc = "Find files by cursor word" }
      )
      -- by yank text
      vim.keymap.set(
        "n",
        "<leader>Fpf",
        "<cmd>FzfxFilesP<cr>",
        { silent = true, noremap = true, desc = "Find files by yank text" }
      )

      -- ======== live grep ========

      -- live grep
      vim.keymap.set("n", "<leader>Fl", "<cmd>FzfxLiveGrep<cr>", { silent = true, noremap = true, desc = "Live grep" })
      -- by visual select
      vim.keymap.set("x", "<leader>Fl", "<cmd>FzfxLiveGrepV<cr>", { silent = true, noremap = true, desc = "Live grep" })
      -- by cursor word
      vim.keymap.set(
        "n",
        "<leader>Fwl",
        "<cmd>FzfxLiveGrepW<cr>",
        { silent = true, noremap = true, desc = "Live grep by cursor word" }
      )
      -- by yank text
      vim.keymap.set(
        "n",
        "<leader>Fpl",
        "<cmd>FzfxLiveGrepP<cr>",
        { silent = true, noremap = true, desc = "Live grep by cursor word" }
      )
    end,
    -- keys = lua_keys("linrongbin16/fzfx.nvim"),
  },
}
