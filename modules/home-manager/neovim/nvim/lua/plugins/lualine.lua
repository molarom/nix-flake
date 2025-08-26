-- Statusline
return {
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
        theme = 'auto',
        disabled_filetypes = {
          'NvimTree', 'undotree', 'fugitive',
        },
        component_separators = '|',
        section_separators = '',
      },
    },
  },
}
