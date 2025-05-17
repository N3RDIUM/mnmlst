return {
    "dundalek/lazy-lsp.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        { "ms-jpq/coq_nvim", branch = "coq" },
        { "ms-jpq/coq.artifacts", branch = "artifacts" },
        { 'ms-jpq/coq.thirdparty', branch = "3p" }
    },
    init = function()
        vim.g.coq_settings = {
            auto_start = true,
            display = {
                pum = {
                    source_context = { "˹", "˼" }
                }
            }
        }
    end,
    config = function()
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
    end
}

