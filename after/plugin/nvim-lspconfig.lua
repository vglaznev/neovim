-- Taken from nvim-lspconfig server_configuration.md
-- Make aware Lua LSP of neovim 

local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup({
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if vim.uv.fs_stat(path..'/.luarc.json') or vim.uv.fs_stat(path..'/.luarc.jsonc') then
	  		return
	end

	client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
	  runtime = {
		version = 'LuaJIT'
	  },
	  workspace = {
		checkThirdParty = false,
		library = {
		  vim.env.VIMRUNTIME,
		  '${3rd}/luv/library'
		}
	  }
	})
  end,
  settings = {
	Lua = {}
  }
})

lspconfig.ccls.setup({
})

lspconfig.rust_analyzer.setup({
	on_attach = function(client, bufnr)
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    }
})
