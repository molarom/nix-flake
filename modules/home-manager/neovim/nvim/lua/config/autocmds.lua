local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Create autogroup.
local molaromAG = augroup("molarom", { clear = true })

autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = molaromAG,
	desc = "Highlight when yanking",
	pattern = "*",
})

autocmd("VimResized", {
	callback = function()
		vim.cmd("wincmd =")
	end,
	group = molaromAG,
	desc = "Equalize Splits",
})

-- Enable treesitter highlight per filetype
autocmd("FileType", {
	pattern = { "*" },
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		local lang = vim.treesitter.language.get_lang(ft)

		if vim.treesitter.language.add(lang) then
			vim.treesitter.start(args.buf, lang)
		end
	end,
})

-- Folding via treesitter.
autocmd({ "BufEnter", "BufAdd", "BufNew", "BufNewFile", "BufWinEnter" }, {
	group = vim.api.nvim_create_augroup("TS_FOLD_WORKAROUND", {}),
	callback = function()
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.wo.foldlevel = 99
	end,
})
