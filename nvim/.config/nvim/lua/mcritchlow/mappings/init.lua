local ok, wk = pcall(require, "which-key")

if not ok then
	return
end

-- Set keymappings we don't need managed by which-key
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("t", "<C-o>", "<C-\\><C-n>")

-- vsnip mappings
local vsnip_mappings = {
	['<C-j>'] = { "vsnip#expandable() ? '<Plug>(vsnip-expand)': '<C-j>'", '[VSNIP] expand', expr = true },
	['<C-l>'] = { "vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)': '<C-l>'", '[VSNIP] expand or jump', expr = true },
	['<Tab>'] = { "vsnip#jumpable(1) ? '<Plug>(vsnip-jump-next)': '<Tab>'", '[VSNIP] jump to next', expr = true },
	['<S-Tab>'] = { "vsnip#jumpable(-1) ? '<Plug>(vsnip-jump-prev)': '<S-Tab>'", '[VSNIP] jump to previous', expr = true },
}
wk.register(vsnip_mappings, { mode = 'i' })
wk.register(vsnip_mappings, { mode = 's' })

-- normal mode
local normal_opts = {
	mode = "n",
	noremap = true,
	nowait = true,
	prefix = "",
	silent = true,
}

wk.register({
	["Y"] = { "y$", "Y behaves like C and D" },
	["n"] = { "nzz", "[MOVEMENT] Center 'n' search" },
	["N"] = { "Nzz", "[MOVEMENT] Center 'N' search" },
	["*"] = { "*zz", "[MOVEMENT] Center '*' search" },
	["#"] = { "#zz", "[MOVEMENT] Center '#' search" },
	["g*"] = { "g*zz", "[MOVEMENT] Center 'g*' search" },
	["g#"] = { "g#zz", "[MOVEMENT] Center 'g#' search" },
	["<leader><leader>"] = { "<c-^>", "[MOVEMENT] Last file" },
	["<C-n>"] = { "<cmd>NvimTreeToggle<cr> <cmd>NvimTreeRefresh<cr>", "[NVIMTREE] Toggle" },

	["]q"] = { "<cmd>cnext<cr>", "[MOVEMENT] Next quickfix" },
	["[q"] = { "<cmd>cprevious<cr>", "[MOVEMENT] Previous quickfix" },
	["]t"] = { "<cmd>tabn<cr>", "[MOVEMENT] Next tab" },
	["[t"] = { "<cmd>tabp<cr>", "[MOVEMENT] Previous tab" },
	["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "[LSP] Previous diagnostic" },
	["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "[LSP] Next diagnostic" },
	["<leader>l"] = {
		name = "[LSP]",
		e = { "<cmd>lua vim.diagnostic.open_float()<cr>", "[LSP] View diagnosticson cursor" },
	},
	["<leader>h"] = {
		name = "[HARPOON]",
		m = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "[HARPOON] Add file" },
		u = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "[HARPOON] View file menu" },
		c = { "<cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<cr>", "[HARPOON] View command menu" },
		a = { "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", "[HARPOON] Open File 1" },
		s = { "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", "[HARPOON] Open File 2" },
		d = { "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", "[HARPOON] Open File 3" },
		f = { "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", "[HARPOON] Open File 4" },
		t = { "<cmd>lua require('harpoon.term').gotoTerminal(1)<cr>", "[HARPOON] Go to Terminal 1 (docker-compose)" },
		x = { "<cmd>lua require('harpoon.term').gotoTerminal(2)<cr>", "[HARPOON] Go to Terminal 2 (extra)" },
		b = { "<cmd>lua require('harpoon.term').sendCommand(1,1)<cr>", "[HARPOON] Run Compose build" },
		k = { "<cmd>lua require('harpoon.term').sendCommand(2,2)<cr>", "[HARPOON] Run Command 2 (compose down)" },
	},
	["<leader>f"] = {
		name = "[TELESCOPE]",
		a = { "<cmd>lua require('telescope').extensions.githubcoauthors.coauthors()<CR>", "[TELESCOPE] Git Authors" },
		b = { "<cmd>Telescope buffers<cr>", "[TELESCOPE] Find buffers" },
		c = { "<cmd>lua require('mcritchlow.plugins.config.telescope').git_commits_with_sha()<cr>", "[TELESCOPE] Marks" },
		d = { "<cmd>lua require('mcritchlow.plugins.config.telescope').search_dotfiles()<cr>", "[TELESCOPE] Marks" },
		m = { "<cmd>Telescope keymaps<cr>", "[TELESCOPE] Find keymappings" },
		f = { "<cmd>Telescope find_files<cr>", "[TELESCOPE] Find buffers" },
		g = { "<cmd>Telescope git_branches<cr>", "[TELESCOPE] Git branches" },
		h = { "<cmd>Telescope help_tags<cr>", "[TELESCOPE] Help tags" },
		r = { "<cmd>lua require('mcritchlow.plugins.config.telescope').reload()<cr>", "[TELESCOPE] Reload Config" },
		s = { "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep For > ')})<CR>", "[TELESCOPE] Find work by grep" },
		w = { "<cmd>lua require('telescope.builtin').grep_string({search = vim.fn.expand('<cword>')})<cr>", "[TELESCOPE] Find word on cursor" },
	},

	["<leader>t"] = {
		name = "[TEST]",
		f = { "<cmd>TestFile<cr>", "[TEST] Current file" },
		t = { "<cmd>TestNearest<cr>", "[TEST] Nearest test" },
		l = { "<cmd>TestLast<cr>", "[TEST] Last test" },
		s = { "<cmd>TestSuite<cr>", "[TEST] Test suite" },
		v = { "<cmd>TestVisit<cr>", "[TEST] Visit test" },
	},

	["<leader>x"] = {
		name = "[TROUBLE]",
		x = { "<cmd>TroubleToggle<cr>", "[TROUBLE] Toggle menu" },
		w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "[TROUBLE] Workspace diagnostics" },
		d = { "<cmd>TroubleToggle document_diagnostics<cr>", "[TROUBLE] Document diagnostics" },
		q = { "<cmd>TroubleToggle quickfix<cr>", "[TROUBLE] Quickfix" },
		l = { "<cmd>TroubleToggle loclist<cr>", "[TROUBLE] Visit test" },
	},
	["<leader>d"] = {
		b = { "<cmd>GoBreakToggle<cr>", "[DAP] Toggle Breakpoint" },
		d = { "<cmd>GoDebug<cr>", "[DAP] Run debugger" },
		k = { "<cmd>GoDbgKeys<cr>", "[DAP] Show keymapping for debug mode" },
		name = "[DAP]",
		t = { "<cmd>GoDebug -t<cr>", "[DAP] Run debugger for tests" },
	},
}, normal_opts)

wk.setup {}
