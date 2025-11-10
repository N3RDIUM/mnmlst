-- lazy.nvim setup
require("config.lazy")

-- Thanks, theprimeagen!
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.g.mapleader = " "

-- Say goodbye to your mouse!
vim.opt.mouse = ""

-- Recommended maximum line width?
vim.opt.colorcolumn = { "80" }

-- Cursor blinking thing
vim.o.guicursor = table.concat({
  "n-v-c:block-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
  "i-ci:ver25-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
  "r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100"
}, ",")


-- Custom keymaps!
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>fn', ':Neotree filesystem toggle right<cr>', { desc = 'Neotree filesystem' })
vim.keymap.set('n', '<leader>bn', ':Neotree buffers reveal float<cr>', { desc = 'Neotree buffers' })
vim.keymap.set('n', '<leader>gn', ':Neotree git_status reveal float<cr>', { desc = 'Neotree git status' })
vim.keymap.set('n', '<leader>sn', ':Neotree document_symbols toggle left<cr>', { desc = 'Neotree document symbols' })

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Telescope old buffers' })

vim.keymap.set('n', '<leader>st', builtin.treesitter, { desc = 'Telescope treesitter symbols' })

vim.keymap.set('n', '<leader>ct', builtin.commands, { desc = 'Telescope commands' })
vim.keymap.set('c', '<leader>ch', builtin.command_history, { desc = 'Telescope command history' })

vim.keymap.set('n', '<leader>qq', ':qa!<cr>', { desc = 'Force-quit nvim' })
vim.keymap.set('n', '<leader>qa', ':qa<cr>', { desc = 'Quit nvim' })
vim.keymap.set('n', '<leader>qf', ':q!<cr>', { desc = 'Force-close buffer' })
vim.keymap.set('n', '<leader>qo', ':q<cr>', { desc = 'Close buffer' })

vim.keymap.set('n', '<leader>sh', ':split<cr>', { desc = 'Split horizontal' })
vim.keymap.set('n', '<leader>sv', ':vsplit<cr>', { desc = 'Split vertical' })

