require('core.mappings')
require('core.options')

vim.api.nvim_command('packadd kanagawa.nvim')

local ok, _ = pcall(vim.cmd.colorscheme, 'kanagawa-dragon')
if not ok then
	vim.cmd.colorscheme('default')
end
