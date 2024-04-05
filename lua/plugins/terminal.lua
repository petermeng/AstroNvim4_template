return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function ()
      require("toggleterm").setup{
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "horizontal", -- 'vertical' | 'horizontal' | 'tab' | 'float'
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      }
      function _G.set_terminal_keymaps()
      local opts = {noremap = true}
        vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
        vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
      end

      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

      local Terminal = require("toggleterm.terminal").Terminal
      local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

      function _LAZYGIT_TOGGLE()
        lazygit:toggle()
      end
    end

  },
  {
    'christoomey/vim-tmux-navigator',
    lazy = false,
  },
  {
    'tamton-aquib/flirt.nvim',
    config = function()
      require("flirt").setup {
          override_open = true, -- experimental
          close_command = 'Q',
          default_move_mappings = true,   -- <C-arrows> to move floats
          default_resize_mappings = true, -- <A-arrows> to resize floats
          default_mouse_mappings = true,  -- Drag floats with mouse
          exclude_fts = {'notify', 'cmp_menu', 'lazy', 'which-key', 'dashboard', 'alpha', 'Trouble', 'startify', 'aerial'},
          custom_filter = function(buffer, win_config)
              return vim.bo[buffer].filetype == 'cmp_menu' -- avoids animation
          end
          -- more options on the way.
      }
    end
  },
  {
    "theniceboy/joshuto.nvim",
    lazy = false,
  }
}
