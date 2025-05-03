return {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    lazy = false,
    config = function()
        require('dashboard').setup {
            config = {
                week_header = { enable = true },
                shortcut = {},
                packages = { enable = false },
                project = { enable = false },
                mru = { enable = false },
                footer = { "What am I supposed to write here?" },
                disable_move = { true },
            }
        }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
}
