return {
    "dundalek/lazy-lsp.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        { "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/nvim-cmp",
    },
    config = function()
        local lsp_zero = require("lsp-zero")

        lsp_zero.on_attach(function(client, bufnr)
            lsp_zero.default_keymaps({
                buffer = bufnr,
                preserve_mappings = false
            })
        end)

        require("lazy-lsp").setup {
            excluded_servers = {
                "ccls",                            -- prefer clangd
                "denols",                          -- prefer eslint and ts_ls
                "docker_compose_language_service", -- yamlls should be enough?
                "flow",                            -- prefer eslint and ts_ls
                "ltex",                            -- grammar tool using too much CPU
                "quick_lint_js",                   -- prefer eslint and ts_ls
                "scry",                            -- archived on Jun 1, 2023
                "tailwindcss",                     -- associates with too many filetypes
                "biome",                           -- not mature enough to be default
            },
            preferred_servers = {
                python = { "basedpyright", "ruff" },
                markdown = {},
                html = {},
                rust = { "rust_analyzer" },
                typescript = { "ts_ls" },
                javascript = { "eslint" }
            },
            prefer_local = true,

            default_config = {
                flags = {
                    debounce_text_changes = 150,
                },
            },

            configs = {
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                        },
                    },
                },
                rust_analyzer = {
                    settings = {
                        ['rust-analyzer'] = {
                            cargo = {
                                extraArgs = { "--profile", "rust-analyzer" },
                            },
                        }
                    }
                }
            },
        }
    end,
}
