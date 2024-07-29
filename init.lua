require('core.mappings')
require('core.options')
require('core.hide_cmd')

vim.api.nvim_command('packadd kanagawa.nvim')

local ok, _ = pcall(vim.cmd, 'colorscheme kanagawa-dragon')
if not ok then
	vim.cmd 'colorscheme default'
end

require('nvim-treesitter.configs').setup({
highlight = {
	enable = true,
	additional_vim_regex_highlighting = false,
	},
})

require('lualine').setup({
	options = {
		icons_enabled = false
	}
})

require('lspconfig').lua_ls.setup({
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
	  		return
	end

	client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
	  runtime = {
		-- Tell the language server which version of Lua you're using
		-- (most likely LuaJIT in the case of Neovim)
		version = 'LuaJIT'
	  },
	  -- Make the server aware of Neovim runtime files
	  workspace = {
		checkThirdParty = false,
		library = {
		  vim.env.VIMRUNTIME
		  -- Depending on the usage, you might want to add additional paths here.
		  -- "${3rd}/luv/library"
		  -- "${3rd}/busted/library",
		}
		-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
		-- library = vim.api.nvim_get_runtime_file("", true)
	  }
	})
  end,
  settings = {
	Lua = {}
  }
})

require('lspconfig').clangd.setup({
})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
	local bufmap = function(mode, lhs, rhs)
	  local opts = {buffer = true}
	  vim.keymap.set(mode, lhs, rhs, opts)
	end

	-- Displays hover information about the symbol under the cursor
	bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')

	-- Jump to the definition
	bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

	-- Jump to declaration
	bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')

	-- Lists all the implementations for the symbol under the cursor
	bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')

	-- Jumps to the definition of the type symbol
	bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')

	-- Lists all the references 
	bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')

	-- Displays a function's signature information
	bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')

	-- Renames all references to the symbol under the cursor
	bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')

	-- Selects a code action available at the current cursor position
	bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')

	-- Show diagnostics in a floating window
	bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')

	-- Move to the previous diagnostic
	bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')

	-- Move to the next diagnostic
	bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
  end
})
