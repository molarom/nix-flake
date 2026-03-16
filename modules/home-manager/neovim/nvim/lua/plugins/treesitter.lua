return {
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		enabled = true,
		dev = false,
		branch = "main",
		init = function()
			vim.g.no_plugin_maps = true
		end,
	},
	{
		-- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		enabled = true,
		dev = true,
		build = ":TSUpdate",
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		event = { "VeryLazy" },
		config = function()
			-- Enable treesitter highlight per filetype
			vim.api.nvim_create_autocmd("FileType", {
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
			vim.api.nvim_create_autocmd({ "BufEnter", "BufAdd", "BufNew", "BufNewFile", "BufWinEnter" }, {
				group = vim.api.nvim_create_augroup("TS_FOLD_WORKAROUND", {}),
				callback = function()
					vim.opt.foldmethod = "expr"
					vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.wo.foldlevel = 99
				end,
			})
		end,
	},
}
