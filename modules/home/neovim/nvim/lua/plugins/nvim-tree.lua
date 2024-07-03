-- Nice VSCode inspired file explorer.
return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup({
          disable_netrw = false,
          hijack_netrw = true,
          update_focused_file = {
            enable = true,
            update_cwd = true,
          },
          on_attach = require("config.nvim_tree"),
        })
    end,
  },
}
