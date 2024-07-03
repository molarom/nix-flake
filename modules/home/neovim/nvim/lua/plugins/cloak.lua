-- Allows you to mask values based on patterns,
-- good for presentations.
return {
  'laytan/cloak.nvim',
  enabled = true,
  keys = {
    { '<leader>ct',     "<cmd>CloakPreviewLine<CR>",   desc = 'Cloak: [C]loak [T]oggle state' },
    { '<leader>cp',     "<cmd>CloakPreviewLine<CR>",   desc = 'Cloak: [C]loak [P]review line under cursor' },
    { '<leader>ce',     "<cmd>CloakEnable<CR>",        desc = 'Cloak: [C]loak [E]nable' },
    { '<leader>cd',     "<cmd>CloakDisable<CR>",       desc = 'Cloak: [C]loak [D]isable' },
  },
  config = function()
    require("cloak").setup({
        enabled = true,
        cloak_character = "*",
        -- The applied highlight group (colors) on the cloaking, see `:h highlight`.
        highlight_group = "Comment",
        patterns = {
            {
                -- Match any file starting with ".env".
                -- This can be a table to match multiple file patterns.
                file_pattern = {
                    "*.enc.yaml",
                    ".env*",
                },
                -- Match an equals sign and any character after it.
                -- This can also be a table of patterns to cloak,
                -- example: cloak_pattern = { ":.+", "-.+" } for yaml files.
                cloak_pattern = { "=.+", ":.+", "-.+" }
            },
        },
    })
end
}
