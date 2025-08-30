-- Better markdown rendering support, required for avante.
-- System dependencies
--  - pylatexenc 
return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  opts = {
    file_types = { "markdown", "Avante" },
  },
  ft = { "markdown", "Avante" },
}
