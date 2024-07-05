local ok_cmp, cmp = pcall(require, "cmp")
local ok_lspkind, lspkind = pcall(require, "lspkind")

if not ok_cmp then
	return
end

if not ok_lspkind then
	return
end

-- Set custom vsnip_snippet_dir
vim.g.vsnip_snippet_dir = vim.loop.os_homedir() .. "/.config/vsnip"

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm({ select = false }),
	}),
	window = {
		documentation = cmp.config.window.bordered(),
		-- completion = cmp.config.window.bordered(),
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lua' },
		{ name = 'vsnip' },
		{ name = 'path' },
		{ name = 'buffer',
			option = {
				get_bufnrs = function()
					return vim.api.nvim_list_bufs()
				end
			},
		},
	}),
	formatting = {
		format = lspkind.cmp_format({ with_text = true, menu = ({
			buffer = "[Buffer]",
			path = "[Path]",
			nvim_lsp = "[LSP]",
			vsnip = "[Snippet]",
			nvim_lua = "[Lua]",
		}) }),
	},

})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})
