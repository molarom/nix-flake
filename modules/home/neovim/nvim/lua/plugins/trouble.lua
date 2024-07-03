-- LSP message reporting.

return {
  'folke/trouble.nvim',
  cmd = { "TroubleToggle", "Trouble" },
  enabled = true,
  keys = {
    { '<leader>xx', "<cmd>Trouble preview_float<CR>", desc = 'Trouble: [xx] Show Diagnostics' },
    { '<leader>xl', "<cmd>Trouble loclist toggle<CR>", desc = 'Trouble: [xl] Show trouble in location list' },
    { '<leader>xq', "<cmd>Trouble qflist toggle<CR>", desc = 'Trouble: [xq] Show trouble in quickfix' },
    {
      "[q",
      function()
        if require("trouble").is_open() then
          require("trouble").previous({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cprev)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = "Previous trouble/quickfix item",
    },
    {
      "]q",
      function()
        if require("trouble").is_open() then
          require("trouble").next({ skip_groups = true, jump = true })
        else
          local ok, err = pcall(vim.cmd.cnext)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR)
          end
        end
      end,
      desc = "Next trouble/quickfix item",
    },
  },
  config = function ()
    local trouble = require('trouble')
    trouble.setup({
      modes = {
        preview_float = {
          mode = "diagnostics",
          preview = {
            type = "float",
            relative = "editor",
            border = "rounded",
            title = "Preview",
            title_pos = "center",
            position = { 0, -2 },
            size = { width = 0.3, height = 0.3 },
            zindex = 200,
          },
        }
      },
    })
  end
}
