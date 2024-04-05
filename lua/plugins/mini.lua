return {
    {
        'echasnovski/mini.animate',
        version = false,
        lazy = false,
        enabled = false,
        config = function()
            require('mini.animate').setup()
        end
    },
    {
        'echasnovski/mini.move',
        lazy = false,
        version = false,
        config = function()
            require('mini.move').setup()
        end,
    },
    {
        'echasnovski/mini.align',
        lazy = false,
        version = false,
        config = function()
            require('mini.align').setup()
        end
    },
    {
        'echasnovski/mini.indentscope',
        lazy = false,
        version = false,
        config = function()
            require('mini.indentscope').setup()
        end
    },
    {
        'echasnovski/mini.ai',
        lazy = false,
        version = false,
        config = function()
            require('mini.ai').setup()
        end
    },
    {
        'echasnovski/mini.splitjoin',
        lazy = false,
        version = false,
        config = function() require('mini.splitjoin').setup() end
    },
}
