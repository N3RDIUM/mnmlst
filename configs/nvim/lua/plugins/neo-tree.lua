return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
        "3rd/image.nvim"
    },
    config = function()
        require("neo-tree").setup({
            sources = {
                "filesystem",
                "buffers",
                "git_status",
                "document_symbols"
            },
            filesystem = {
                renderers = {
                    directory = {
                        {
                             "indent",
                             with_markers = true,
                             indent_marker = "│",
                             last_indent_marker = "└",
                             indent_size = 2,
                        },
                        {
                            "icon",
                            padding = " "
                        },
                        { "name" }
                    },
                    file = {
                        {
                            "indent",
                            with_markers = true,
                            indent_marker = "│",
                            last_indent_marker = "└",
                            indent_size = 2,
                        },
                        {
                            "icon",
                            padding = " "
                        },
                        { "name" },
                        { "bufnr" },
                        { "git_status" }
                    },
                }
            },
        })
    end
}
