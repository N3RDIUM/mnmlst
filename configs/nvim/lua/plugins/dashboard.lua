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
                footer = { "Mankind was born on Earth. It was never meant to die here." },
                disable_move = { true },
            }
        }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
}
