return {
    "nvim-treesitter/nvim-treesitter",
    priority = 1000,
    lazy = false,
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    config = function()
        vim.opt.runtimepath:append("/home/n3rdium/.tsparsers");

        require 'nvim-treesitter.configs'.setup {
            ensure_installed = { "python", "rust", "html", "javascript", "css", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
            auto_install = true,
            parser_install_dir = "/home/n3rdium/.tsparsers",
            indent = { enable = true },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        }
    end
}
