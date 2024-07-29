vim.g.mapleader = ' '

vim.keymap.set('n', '<Leader>ff', '<cmd>lua require(\'fzf-lua\').files()<cr>', {noremap = true, silent = false})
vim.keymap.set('n', '<Leader>fg', '<cmd>lua require(\'fzf-lua\').grep()<cr>', {noremap = true, silent = false})
