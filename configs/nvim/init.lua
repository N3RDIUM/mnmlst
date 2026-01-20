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

-- coq.nvim configuration
vim.g.coq_settings = {
    auto_start = true,
    display = {
        statusline = {
            helo = false,
        },
        pum = {
            kind_context = {" [", "]"},
            source_context = {"˹", "˼"}
        }
    },
}

-- Recommended maximum line width?
vim.opt.colorcolumn = { "80" }

-- LSP diagnostics config
vim.diagnostic.config({
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})
vim.keymap.set("n", "<A-l>", function()
  vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines })
end, { desc = "Toggle LSP virtual lines" })

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "!",
      [vim.diagnostic.severity.WARN]  = "▴",
      [vim.diagnostic.severity.INFO]  = "i",
      [vim.diagnostic.severity.HINT]  = "🟅",
    },
  },
})

-- Cursor blinking thing
vim.o.guicursor = table.concat({
  "n-v-c:block-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
  "i-ci:ver25-Cursor/lCursor-blinkwait1000-blinkon100-blinkoff100",
  "r:hor50-Cursor/lCursor-blinkwait100-blinkon100-blinkoff100"
}, ",")

-- Custom keymaps!
local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>fn', ':NvimTreeToggle<cr>', { desc = 'Toggle nvim-tree' })

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

-- barbar.nvim
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)

map('n', '<A-C-,>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A-C-.>', '<Cmd>BufferMoveNext<CR>', opts)

map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)

map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)

-- leap.nvim
-- I'm not ready for this yet, I guess
--[[
vim.keymap.set({'n', 'o'}, 'gs', function ()
  require('leap.remote').action {
    -- Automatically enter Visual mode when coming from Normal.
    input = vim.fn.mode(true):match('o') and '' or 'v'
  }
end)
-- Forced linewise version (`gS{leap}jjy`):
vim.keymap.set({'n', 'o'}, 'gS', function ()
  require('leap.remote').action { input = 'V' }
end)

vim.keymap.set({'x', 'o'}, 'R',  function ()
  require('leap.treesitter').select {
    opts = require('leap.user').with_traversal_keys('R', 'r')
  }
end)

-- Highly recommended: define a preview filter to reduce visual noise
-- and the blinking effect after the first keypress
-- (`:h leap.opts.preview`). You can still target any visible
-- positions if needed, but you can define what is considered an
-- exceptional case.
-- Exclude whitespace and the middle of alphabetic words from preview:
--   foobar[baaz] = quux
--   ^----^^^--^^-^-^--^
require('leap').opts.preview = function (ch0, ch1, ch2)
  return not (
    ch1:match('%s')
    or (ch0:match('%a') and ch1:match('%a') and ch2:match('%a'))
  )
end

-- Define equivalence classes for brackets and quotes, in addition to
-- the default whitespace group:
require('leap').opts.equivalence_classes = {
  ' \t\r\n', '([{', ')]}', '\'"`'
}

-- Use the traversal keys to repeat the previous motion without
-- explicitly invoking Leap:
require('leap.user').set_repeat_keys('<enter>', '<backspace>')
]]--

