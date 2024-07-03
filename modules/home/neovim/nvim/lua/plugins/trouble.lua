-- LSP message reporting.

return {
  'folke/trouble.nvim',
  cmd = { "TroubleToggle", "Trouble" },
  opts = {
    use_diagnostic_signs = true,
    modes = {
      test = {
        mode = "diagnostics",
        preview = {
          type = "split",
          relative = "win",
          position = "right",
          size = 0.3,
        },
      },
    },
  },
  enabled = true,
  keys = {
    { '<leader>xx', "<cmd>Trouble diagnostics toggle<CR>", desc = 'Trouble: [xx] Show Diagnostics' },
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
}
