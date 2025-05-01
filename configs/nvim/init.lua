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

-- Custom keymaps!
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })

vim.keymap.set('n', '<leader>bf', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>bo', builtin.oldfiles, { desc = 'Telescope old buffers' })

vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Telescope git commits' })
vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Telescope git status' })
vim.keymap.set('n', '<leader>gS', builtin.git_stash, { desc = 'Telescope git stash' })

vim.keymap.set('n', '<leader>lf', builtin.treesitter, { desc = 'Telescope treesitter symbols' })

vim.keymap.set('n', '<leader>cf', builtin.commands, { desc = 'Telescope commands' })
vim.keymap.set('c', '<C-h>', builtin.command_history, { desc = 'Telescope command history' })

vim.keymap.set('n', '<leader>qq', ':qa!<cr>', { desc = 'Force-quit nvim' })
vim.keymap.set('n', '<leader>qa', ':qa<cr>', { desc = 'Quit nvim' })
vim.keymap.set('n', '<leader>qf', ':q!<cr>', { desc = 'Force-close buffer' })
vim.keymap.set('n', '<leader>qo', ':q<cr>', { desc = 'Close buffer' })

vim.keymap.set('n', '<leader>sh', ':split<cr>', { desc = 'Split horizontal' })
vim.keymap.set('n', '<leader>sv', ':vsplit<cr>', { desc = 'Split vertical' })

