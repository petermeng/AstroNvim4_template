vim.cmd [[
fun! s:MakePair()
	let line = getline('.')
	let len = strlen(line)
	if line[len - 1] == ";" || line[len - 1] == ","
		normal! lx$P
	else
		normal! lx$p
	endif
endfun
inoremap <c-u> <ESC>:call <SID>MakePair()<CR>
]]
return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "User AstroFile",
    config = function(_, opts) require "rainbow-delimiters.setup"(opts) end,
  },
  {
    "smoka7/multicursors.nvim",
    enabled = false,
    event = "VeryLazy",
    dependencies = {
      "smoka7/hydra.nvim",
    },
    opts = function()
      local N = require "multicursors.normal_mode"
      local I = require "multicursors.insert_mode"
      return {
        normal_keys = {
          -- to change default lhs of key mapping change the key
          ["b"] = {
            -- assigning nil to method exits from multi cursor mode
            method = N.clear_others,
            -- description to show in hint window
            desc = "Clear others",
          },
        },
        insert_keys = {
          -- to change default lhs of key mapping change the key
          ["<CR>"] = {
            -- assigning nil to method exits from multi cursor mode
            method = I.Cr_method,
            -- description to show in hint window
            desc = "new line",
          },
        },
      }
    end,
    keys = {
      {
        "<Leader>L",
        "<cmd>MCstart<cr>",
        desc = "Create a selection for word under the cursor",
      },
    },
    config = function() require("multicursors").setup { opts } end,
  },
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   event = "User AstroFile",
  --   opts = {
  --     char = "│",
  --     filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
  --     show_trailing_blankline_indent = false,
  --     show_current_context = false,
  --   },
  --   config = function()
  --     vim.opt.termguicolors = true
  --     vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
  --     vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
  --     vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
  --     vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
  --     vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
  --     vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]
  --
  --     vim.opt.list = true
  --     vim.opt.listchars:append "space:󰇘"
  --     vim.opt.listchars:append "eol:󱞣"
  --
  --     require("indent_blankline").setup {
  --         space_char_blankline = " ",
  --         char_highlight_list = {
  --             "IndentBlanklineIndent1",
  --             "IndentBlanklineIndent2",
  --             "IndentBlanklineIndent3",
  --             "IndentBlanklineIndent4",
  --             "IndentBlanklineIndent5",
  --             "IndentBlanklineIndent6",
  --         },
  --     }
  --   end,
  -- },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      vim.opt.termguicolors = true
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local s = " "
        for e, n in pairs(diagnostics_dict) do
          local sym = e == "error" and " " or (e == "warning" and " " or "")
          s = s .. n .. sym
        end
        return s
      end
      require("bufferline").setup()
    end,
  },
  {
    "RRethy/vim-illuminate",
    lazy = false,
    config = function()
      require("illuminate").configure {
        providers = {
          -- 'lsp',
          -- 'treesitter',
          "regex",
        },
      }
      vim.cmd "hi IlluminatedWordText guibg=#393E4D gui=none"
    end,
  },
  {
    "dkarter/bullets.vim",
    lazy = false,
    ft = { "markdown", "txt" },
  },
  -- {
  -- 	"psliwka/vim-smoothie",
  -- 	init = function()
  -- 		vim.cmd([[nnoremap <unique> <C-e> <cmd>call smoothie#do("\<C-D>") <CR>]])
  -- 		vim.cmd([[nnoremap <unique> <C-u> <cmd>call smoothie#do("\<C-U>") <CR>]])
  -- 	end
  -- },
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      filetypes = { "*" },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = true, -- "Name" codes like Blue or blue
        RRGGBBAA = false, -- #RRGGBBAA hex codes
        AARRGGBB = true, -- 0xAARRGGBB hex codes
        rgb_fn = false, -- CSS rgb() and rgba() functions
        hsl_fn = false, -- CSS hsl() and hsla() functions
        css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "virtualtext", -- Set the display mode.
        -- Available methods are false / true / "normal" / "lsp" / "both"
        -- True is same as normal
        tailwind = true,
        sass = { enable = false },
        virtualtext = "■",
      },
      -- all the sub-options of filetypes apply to buftypes
      buftypes = {},
    },
  },
  {
    "theniceboy/antovim",
    lazy = false,
  },
  {
    "gcmt/wildfire.vim",
    lazy = false,
  },
  -- {
  --    "fedepujol/move.nvim",
  --    lazy = false,
  --    config = function()
  --      local opts = { noremap = true, silent = true }
  --      -- Normal-mode commands
  --      vim.keymap.set('n', '<A-j>', ':MoveLine(1)<CR>', opts)
  --      vim.keymap.set('n', '<A-k>', ':MoveLine(-1)<CR>', opts)
  --      vim.keymap.set('n', '<A-h>', ':MoveHChar(-1)<CR>', opts)
  --      vim.keymap.set('n', '<A-l>', ':MoveHChar(1)<CR>', opts)
  --      vim.keymap.set('n', '<leader>wf', ':MoveWord(1)<CR>', opts)
  --      vim.keymap.set('n', '<leader>wb', ':MoveWord(-1)<CR>', opts)
  --
  --      -- Visual-mode commands
  --      vim.keymap.set('v', '<A-j>', ':MoveBlock(1)<CR>', opts)
  --      vim.keymap.set('v', '<A-k>', ':MoveBlock(-1)<CR>', opts)
  --      vim.keymap.set('v', '<A-h>', ':MoveHBlock(-1)<CR>', opts)
  --      vim.keymap.set('v', '<A-l>', ':MoveHBlock(1)<CR>', opts)
  --    end
  -- },
  {
    "gbprod/yanky.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },

  {
    "gbprod/substitute.nvim",
    config = function()
      local substitute = require "substitute"
      substitute.setup {
        on_substitute = require("yanky.integration").substitute(),
        highlight_substituted_text = {
          enabled = true,
          timer = 200,
        },
      }
      vim.keymap.set("n", "s", substitute.operator, { noremap = true })
      vim.keymap.set("n", "sh", function() substitute.operator { motion = "e" } end, { noremap = true })
      vim.keymap.set("x", "s", require("substitute.range").visual, { noremap = true })
      vim.keymap.set("n", "ss", substitute.line, { noremap = true })
      vim.keymap.set("n", "sI", substitute.eol, { noremap = true })
      vim.keymap.set("x", "s", substitute.visual, { noremap = true })
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function() require("ufo").setup() end,
  },
  {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end,
  },
  {
    "tpope/vim-surround",
    event = "User AstroFile",
  },
  {
    "tpope/vim-repeat",
    event = "User AstroFile",
  },
  {
    "glts/vim-radical",
    event = "User AstroFile",
    dependencies = "glts/vim-magnum",
  },
  {
    "azabiong/vim-highlighter",
    event = "User AstroFile",
    config = function()
      vim.cmd [[
          let HiSet   = 'L<CR>'
          let HiErase = 'L<BS>'
          let HiClear = 'L<C-L>'
          let HiFind  = 'L<Tab>'
          let HiSetSL = 't<CR>'
      ]]
    end,
  },
  {
    "chentoast/marks.nvim",
    event = "User AstroFile",
    config = function()
      require("marks").setup {
        -- whether to map keybinds or not. default true
        default_mappings = true,
        -- which builtin marks to show. default {}
        builtin_marks = { ".", "<", ">", "^" },
        -- whether movements cycle back to the beginning/end of buffer. default true
        cyclic = true,
        -- whether the shada file is updated after modifying uppercase marks. default false
        force_write_shada = false,
        -- how often (in ms) to redraw signs/recompute mark positions.
        -- higher values will have better performance but may cause visual lag,
        -- while lower values may cause performance penalties. default 150.
        refresh_interval = 250,
        -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
        -- marks, and bookmarks.
        -- can be either a table with all/none of the keys, or a single number, in which case
        -- the priority applies to all marks.
        -- default 10.
        sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
        -- disables mark tracking for specific filetypes. default {}
        excluded_filetypes = {},
        -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
        -- sign/virttext. Bookmarks can be used to group together positions and quickly move
        -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
        -- default virt_text is "".
        bookmark_0 = {
          sign = "⚑",
          virt_text = "hello world",
          -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
          -- defaults to false.
          annotate = false,
        },
      }
    end,
  },
  {
    "jesseleite/vim-agriculture",
    event = "User AstroFile",
  },
  {
    "rainbowhxch/accelerated-jk.nvim",
    lazy = false,
    enabled = false,
    config = function()
      require("accelerated-jk").setup {
        mode = "time_driven",
        enable_deceleration = false,
        acceleration_motions = {},
        acceleration_limit = 150,
        acceleration_table = { 7, 12, 17, 21, 24, 26, 28, 30 },
        -- when 'enable_deceleration = true', 'deceleration_table = { {200, 3}, {300, 7}, {450, 11}, {600, 15}, {750, 21}, {900, 9999} }'
        deceleration_table = { { 150, 9999 } },
      }
      vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj)", {})
      vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk)", {})
    end,
  },
  {
    "anuvyklack/windows.nvim",
    lazy = false,
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    config = function()
      vim.api.nvim_set_keymap("n", "<C-w>z", "<cmd> WindowsMaximize<CR>", { desc = "Max the current Window" })
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require("windows").setup()
    end,
  },
  {
    "anuvyklack/pretty-fold.nvim",
    lazy = false,
    enabled = false,
    config = function()
      require("pretty-fold").setup {
        sections = {
          left = {
            "━ ",
            function() return string.rep("*", vim.v.foldlevel) end,
            " ━┫",
            "content",
            "┣",
          },
          right = {
            "┫ ",
            "number_of_folded_lines",
            ": ",
            "percentage",
            " ┣━━",
          },
        },

        fill_char = "━",

        remove_fold_markers = false,

        -- Keep the indentation of the content of the fold string.
        keep_indentation = true,

        -- Possible values:
        -- "delete" : Delete all comment signs from the fold string.
        -- "spaces" : Replace all comment signs with equal number of spaces.
        -- false    : Do nothing with comment signs.
        process_comment_signs = "spaces",

        -- Comment signs additional to the value of `&commentstring` option.
        comment_signs = {},

        -- List of patterns that will be removed from content foldtext section.
        stop_words = {
          "@brief%s*", -- (for C++) Remove '@brief' and all spaces after.
        },

        add_close_pattern = true, -- true, 'last_line' or false

        matchup_patterns = {
          { "{", "}" },
          { "%(", ")" }, -- % to escape lua pattern char
          { "%[", "]" }, -- % to escape lua pattern char
        },

        ft_ignore = { "neorg" },
      }
    end,
  },
  {
    "RaafatTurki/hex.nvim",
    lazy = false,
    config = function() require("hex").setup() end,
  },
  {
    "cds-amal/hexer-nvim",
    name = "hexer",
    lazy = false,
    config = function() end,
  },
  {
    "mg979/vim-visual-multi",
    keys = {
      "<C-N>",
    },
  },
  {
    "AckslD/muren.nvim",
    lazy = false,
    config = function()
      require("muren").setup {
        -- general
        create_commands = true,
        filetype_in_preview = true,
        -- default togglable options
        two_step = false,
        all_on_line = true,
        preview = true,
        cwd = false,
        files = "**/*",
        -- keymaps
        keys = {
          close = "q",
          toggle_side = "<Tab>",
          toggle_options_focus = "<C-s>",
          toggle_option_under_cursor = "<CR>",
          scroll_preview_up = "<Up>",
          scroll_preview_down = "<Down>",
          do_replace = "<CR>",
          -- NOTE these are not guaranteed to work, what they do is just apply `:normal! u` vs :normal! <C-r>`
          -- on the last affected buffers so if you do some edit in these buffers in the meantime it won't do the correct thing
          do_undo = "<localleader>u",
          do_redo = "<localleader>r",
        },
        -- ui sizes
        patterns_width = 30,
        patterns_height = 10,
        options_width = 20,
        preview_height = 12,
        -- window positions
        anchor = "center", -- Set to one of:
        -- 'center' | 'top' | 'bottom' | 'left' | 'right' | 'top_left' | 'top_right' | 'bottom_left' | 'bottom_right'
        vertical_offset = 0, -- offsets are relative to anchors
        horizontal_offset = 0,
        -- options order in ui
        order = {
          "buffer",
          "dir",
          "files",
          "two_step",
          "all_on_line",
          "preview",
        },
        -- highlights used for options ui
        hl = {
          options = {
            on = "@string",
            off = "@variable.builtin",
          },
          preview = {
            cwd = {
              path = "Comment",
              lnum = "Number",
            },
          },
        },
      }
    end,
  },
  {
    "jackMort/pommodoro-clock.nvim",
    lazy = false,
    config = function()
      require("pommodoro-clock").setup {
        -- optional configuration
        modes = {
          ["work"] = { "POMMODORO", 25 },
          ["short_break"] = { "SHORT BREAK", 5 },
          ["long_break"] = { "LONG BREAK", 30 },
        },
        animation_duration = 300,
        animation_fps = 30,
        say_command = "spd-say -l en -t female3",
        sound = "voice", -- set to "none" to disable
      }

      local function pc(func) return "<Cmd>lua require('pommodoro-clock')." .. func .. "<CR>" end

      local wk_avail, wk = pcall(require, "which-key")
      if wk_avail then
        wk.register {
          ["<Leader>P"] = {
            name = "Pommodoro",
            w = { pc 'start("work")', "Start Pommodoro" },
            s = { pc 'start("short_break")', "Short Break" },
            l = { pc 'start("long_break")', "Long Break" },
            p = { pc "toggle_pause()", "Toggle Pause" },
            c = { pc "close()", "Close" },
          },
        }
      end
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "folke/which-key.nvim",
    },
  },
  {
    "edluffy/hologram.nvim",
    enabled = false,
    event = "User AstroFile",
    config = function()
      require("hologram").setup {
        auto_display = true, -- WIP automatic markdown image display, may be prone to breaking
      }
    end,
  },
  {
    "monaqa/dial.nvim",
    event = "User AstroFile",
    config = function()
      local augend = require "dial.augend"
      require("dial.config").augends:register_group {
        -- default augends used when no group name is specified
        default = {
          augend.integer.alias.decimal, -- nonnegative decimal number (0, 1, 2, 3, ...)
          augend.integer.alias.hex, -- nonnegative hex number  (0x01, 0x1a1f, etc.)
          augend.date.alias["%Y/%m/%d"], -- date (2022/02/19, etc.)
        },

        -- augends used when group with name `mygroup` is specified
        mygroup = {
          augend.integer.alias.decimal,
          augend.constant.alias.bool, -- boolean value (true <-> false)
          augend.date.alias["%m/%d/%Y"], -- date (02/19/2022, etc.)
        },
      }
      local wk_avail, wk = pcall(require, "which-key")
      if wk_avail then
        wk.register {
          ["<Leader>D"] = {
            name = "Dial",
          },
        }

        vim.keymap.set("n", "<leader>Da", require("dial.map").inc_normal(), { noremap = true, desc = "Increase" })
        vim.keymap.set("n", "<leader>Dx", require("dial.map").dec_normal(), { noremap = true, desc = "Descrease" })
        vim.keymap.set(
          "n",
          "<leader>Dga",
          require("dial.map").inc_gnormal(),
          { noremap = true, desc = "Global increase" }
        )
        vim.keymap.set(
          "n",
          "<leader>Dgx",
          require("dial.map").dec_gnormal(),
          { noremap = true, desc = "Global descrease" }
        )
        vim.keymap.set(
          "n",
          "N",
          "Nzzzv",
          { noremap = true, desc = "search word down, and cursor in the middle of the screen" }
        )
        vim.keymap.set(
          "n",
          "n",
          "nzzzv",
          { noremap = true, desc = "search word up, and cursor in the middle of the screen" }
        )
        vim.keymap.set(
          "n",
          "<leader>uD",
          "<cmd>Telescope undo<cr>",
          { noremap = true, desc = "Open undo Tree" }
        )
        vim.keymap.set(
          "n",
          "<leader>ga",
          "<cmd>lua _LAZYGIT_TOGGLE()<cr>",
          { noremap = true, desc = "Open Lazygit" }
        )
        vim.keymap.set(
          "n",
          "<leader>Ls",
          "<cmd>lua vim.g.cscope_maps_db_file=\"./.exvim.yproject/cscope.out\"<cr>",
          { noremap = true, desc = "Open Y Cscope" }
        )
        vim.keymap.set(
          "n",
          "<leader>Lc",
          "<cmd>set tags=\"./.exvim.yproject/ctags\"<cr>",
          { noremap = true, desc = "Open Y Ctags" }
        )
        vim.keymap.set("v", "<leader>Da", require("dial.map").inc_visual(), { noremap = true, desc = "Increase" })
        vim.keymap.set("v", "<leader>Dx", require("dial.map").dec_visual(), { noremap = true, desc = "Descrease" })
        vim.keymap.set(
          "v",
          "<leader>Dga",
          require("dial.map").inc_gvisual(),
          { noremap = true, desc = "Global increase" }
        )
        vim.keymap.set(
          "v",
          "<leader>Dgx",
          require("dial.map").dec_gvisual(),
          { noremap = true, desc = "Global descrease" }
        )
        vim.keymap.set(
          "v",
          "J",
          ":m '>+1<CR>gv=gv",
          { noremap = true, desc = "Visual Mode move line up" }
        )
        vim.keymap.set(
          "v",
          "K",
          ":m '<-2<CR>gv=gv",
          { noremap = true, desc = "Visual Mode move line down" }
        )
      end
    end,
  },
  {
    "lukas-reineke/virt-column.nvim",
    event = "User AstroFile",
    config = function()
      require("virt-column").setup {
        enabled = true,
        char = "┃",
        virtcolumn = "+1,120",
      }
    end,
  },
  {
    "mikesmithgh/kitty-scrollback.nvim",
    enabled = true,
    lazy = true,
    cmd = { "KittyScrollbackGenerateKittens", "KittyScrollbackCheckHealth" },
    event = { "User KittyScrollbackLaunch" },
    -- version = '*', -- latest stable version, may have breaking changes if major version changed
    -- version = '^4.0.0', -- pin major version, include fixes and features that do not have breaking changes
    config = function() require("kitty-scrollback").setup() end,
  },
  {
    "HampusHauffman/bionic.nvim",
    enabled = false,
    event = "User AstroFile",
    config = function()
      vim.cmd [[
          augroup BionicAutocmd
            autocmd!
            autocmd FileType * Bionic
          augroup END
        ]]
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      icons = { group = vim.g.icons_enabled and "" or "+", separator = "" },
      disable = { filetypes = { "TelescopePrompt" } },
    },
    config = function()
      require("which-key").setup(opts)
      require("astrocore").which_key_register()
    end,
  },
  {
    "NStefan002/screenkey.nvim",
    cmd = "Screenkey",
    version = "*",
    config = true,
  },
  {
    "cbochs/grapple.nvim",
    opts = {
        scope = "git", -- also try out "git_branch"
    },
    event = { "BufReadPost", "BufNewFile" },
    cmd = "Grapple",
    keys = {
        { "<leader>Mm", "<cmd>Grapple toggle<cr>", desc = "Grapple toggle tag" },
        { "<leader>MM", "<cmd>Grapple toggle_tags<cr>", desc = "Grapple open tags window" },
        { "<leader>Mn", "<cmd>Grapple cycle_tags next<cr>", desc = "Grapple cycle next tag" },
        { "<leader>Mp", "<cmd>Grapple cycle_tags prev<cr>", desc = "Grapple cycle previous tag" },
    },
  },
  {
    "otavioschwanck/arrow.nvim",
    config = function()
      require('arrow').setup({
        buffer_leader_key = 'm', -- Per Buffer Mappings
        show_icons = true,
        always_show_path = false,
        separate_by_branch = false, -- Bookmarks will be separated by git branch
        hide_handbook = false, -- set to true to hide the shortcuts on menu.
        save_path = function()
          return vim.fn.stdpath("cache") .. "/arrow"
        end,
        mappings = {
          edit = "e",
          delete_mode = "d",
          clear_all_items = "C",
          toggle = "s", -- used as save if separate_save_and_remove is true
          open_vertical = "v",
          open_horizontal = "-",
          quit = "q",
          remove = "x", -- only used if separate_save_and_remove is true
          next_item = "]",
          prev_item = "["
        },
        custom_actions = {
          open = function(target_file_name, current_file_name) end, -- target_file_name = file selected to be open, current_file_name = filename from where this was called
          split_vertical = function(target_file_name, current_file_name) end,
          split_horizontal = function(target_file_name, current_file_name) end,
        },
        window = { -- controls the appearance and position of an arrow window (see nvim_open_win() for all options)
          width = "auto",
          height = "auto",
          row = "auto",
          col = "auto",
          border = "double",
        },
        per_buffer_config = {
          lines = 4, -- Number of lines showed on preview.
          sort_automatically = true, -- Auto sort buffer marks.
          satellite = { -- defualt to nil, display arrow index in scrollbar at every update
            enable = false,
            overlap = true,
            priority = 1000,
          },
          zindex = 10, --default 50
          treesitter_context = nil, -- it can be { line_shift_down = 2 }, currently not usable, for detail see https://github.com/otavioschwanck/arrow.nvim/pull/43#issue-2236320268
        },
        separate_save_and_remove = false, -- if true, will remove the toggle and create the save/remove keymaps.
        leader_key = ";",
        save_key = "cwd", -- what will be used as root to save the bookmarks. Can be also `git_root`.
        global_bookmarks = false, -- if true, arrow will save files globally (ignores separate_by_branch)
        index_keys = "123456789zxcbnmZXVBNM,afghjklAFGHJKLwrtyuiopWRTYUIOP", -- keys mapped to bookmark index, i.e. 1st bookmark will be accessible by 1, and 12th - by c
        full_path_list = { "update_stuff" } -- filenames on this list will ALWAYS show the file path too.
      })
    end,
  },
  {
    'mrjones2014/legendary.nvim',
    -- since legendary.nvim handles all your keymaps/commands,
    -- its recommended to load legendary.nvim before other plugins
    priority = 10000,
    lazy = false,
    -- sqlite is only needed if you want to use frecency sorting
    -- dependencies = { 'kkharji/sqlite.lua' }
  },
}
