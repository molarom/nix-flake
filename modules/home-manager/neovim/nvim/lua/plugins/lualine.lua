-- Statusline
return {
	{
		"nvim-lualine/lualine.nvim",
		opts = {
			options = {
				icons_enabled = true,
				theme = "auto",
				disabled_filetypes = {
					"neo-tree",
					"undotree",
					"fugitive",
					"Avante",
				},
				component_separators = "|",
				section_separators = "",
			},
		},
	},
}
