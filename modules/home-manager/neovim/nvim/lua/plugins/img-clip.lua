-- support for image pasting
-- System requirements:
--  - Linux: xclip (X11)
--  - MacOS: pngpaste
return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  keys = {
    -- suggested keymap
    { "<leader>pi", "<cmd>PasteImage<cr>", desc = "[P]aste [i]mage from system clipboard" },
  },
  opts = {
    -- recommended settings
    default = {
      embed_image_as_base64 = false,
      prompt_for_file_name = false,
      drag_and_drop = {
        insert_mode = true,
      },
      -- required for Windows users
      use_absolute_path = true,
    },
  },
}
