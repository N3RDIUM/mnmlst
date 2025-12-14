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
            use_vim_lsp_config = true,

            on_attach = function(client, bufnr)
                -- enable inlay hints if supported
                if client.server_capabilities.inlayHintProvider then
                    vim.lsp.buf.inlay_hint(bufnr, true)
                end
            end,

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
                "glslls",                          -- very annoying
            },
            preferred_servers = {
                python = { "basedpyright", "ruff" },
                markdown = {},
                html = {},
                rust = { "rust_analyzer" },
                typescript = { "ts_ls" },
                javascript = { "eslint" },
                glsl = { "glslls" },
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
            },
        }
    end
}

