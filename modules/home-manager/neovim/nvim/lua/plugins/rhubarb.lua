-- Git remote repository browser.
return {
  'tpope/vim-rhubarb',
  enabled = true,
  keys = {
    { '<leader>gb', "<cmd>GBrowse<CR>", desc = 'Rhubarb: open the current repository\'s file in a web browser (GitHub only)' },
  },
}
