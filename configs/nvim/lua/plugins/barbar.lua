return {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons'
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
        animation = false,
        icons = {
            filetype = {
                enabled = true,
                custom = function(_, _, icon)
                    return icon .. "  "
                end,
            },
        },
    },
    version = '^1.0.0'
}
