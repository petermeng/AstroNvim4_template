return {
	{
		"Eandrju/cellular-automaton.nvim",
		enabled = true,
		keys = {
			"<leader>rr",
			"<leader>rg"
		},
		config = function()
			vim.keymap.set("n", "<leader>rr", "<cmd>CellularAutomaton make_it_rain<CR>", { noremap=true, desc = "Fun: run raining" })
			vim.keymap.set("n", "<leader>rg", "<cmd>CellularAutomaton game_of_life<CR>", { noremap=true, desc = "Fun: run game of life" })
		end,
	},
	{
		'tamton-aquib/zone.nvim',
		config = function()
			require('zone').setup {
    			style = "treadmill",
    			after = 30,          -- Idle timeout
    			exclude_filetypes = { "TelescopePrompt", "NvimTree", "neo-tree", "dashboard", "lazy" },
    			-- More options to come later

    			treadmill = {
        			direction = "left",
        			headache = true,
        			tick_time = 30,     -- Lower, the faster
        			-- Opts for Treadmill style
    			},
    			epilepsy = {
        			stage = "aura",     -- "aura" or "ictal"
        			tick_time = 100,
    			},
    			dvd = {
        			-- text = {"line1", "line2", "line3", "etc"}
        			tick_time = 100,
        			-- Opts for Dvd style
    			},
    			-- etc
			}
		end
	},
	{
		'tamton-aquib/keys.nvim',
		cmd="KeysToggle",
		config = function()
			require('keys').setup {
	    		enable_on_startup = true,
    			win_opts = {
        			width = 25
        			-- etc
    			},
    		}
		end
	},
	{
		'tamton-aquib/duck.nvim',
		keys = {
			"<leader>rd",
			"<leader>rk"
		},
		ejabled = true,
		config = function()
        	vim.keymap.set('n', '<leader>rd', function() require("duck").hatch("🐈", 0.75) end, { noremap=true, desc = "duck enable" })
        	vim.keymap.set('n', '<leader>rk', function() require("duck").cook() end, { noremap=true, desc = "duck disable" })
	    end
	},
	{
  	  'alec-gibson/nvim-tetris',
  	  cmd = "Tetris",
	},
	{
  	  'seandewar/nvimesweeper',
  	  cmd = "Nvimesweeper",
	},
	{
  	  'seandewar/killersheep.nvim',
  	  cmd = "KillKillKill",
  	  config = function()
  	    require("killersheep").setup {
          gore = true,           -- Enables/disables blood and gore.
          keymaps = {
            move_left = "h",     -- Keymap to move cannon to the left.
            move_right = "l",    -- Keymap to move cannon to the right.
            shoot = "<Space>",   -- Keymap to shoot the cannon.
          },
        }
  	  end
	},
	{
  	  'jim-fx/sudoku.nvim',
  	  cmd = "Sudoku",
  	  config = function()
    	require("sudoku").setup({
      	  -- configuration ...
    	})
  	  end
	},
}
