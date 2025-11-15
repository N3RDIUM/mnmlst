return {
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        config = function()
            require("nvim-tree").setup({
                view = {
                    side = "right",
                    width = 42,
                },
                renderer = {
                    icons = {
                        padding = "  ",
                    },
                },
            })
        end,
    },
}

