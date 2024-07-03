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
          update_focused_file = {
            enable = true,
            update_cwd = true,
          },
          on_attach = require("config.nvim-tree_keymaps"),
        })
    end,
  },
}
