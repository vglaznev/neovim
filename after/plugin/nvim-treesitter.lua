require('nvim-treesitter.configs').setup({
ensure_installed = { 'c', 'cpp', 'lua', 'vimdoc', 'markdown' },
highlight = {
	enable = true,
	additional_vim_regex_highlighting = false,
	},
})
