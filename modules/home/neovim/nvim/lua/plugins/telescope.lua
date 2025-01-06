-- Fuzzy finder (file, lsp, etc.)
return {
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native',
        dev = true;
      },
    },
    keys = {
      { '<leader>?',        "<cmd> Telescope oldfiles<CR>",                  desc = 'Telescope: [?] Find recently opened files' },
      { '<leader><space>',  "<cmd> Telescope buffers<CR>",                   desc = 'Telescope: [ ] Find existing buffers' },
      { '<leader>/',        "<cmd> Telescope current_buffer_fuzzy_find<CR>", desc = 'Telescope: [/] Fuzzily search in current buffer' },
      { '<leader>sf',       "<cmd> Telescope find_files<CR>",                desc = 'Telescope: [S]earch [F]iles' },
      { '<leader>sh',       "<cmd> Telescope help_tags<CR>",                 desc = 'Telescope: [S]earch [H]elp' },
      { '<leader>sw',       "<cmd> Telescope grep_string<CR>",               desc = 'Telescope: [S]earch current [W]ord' },
      { '<leader>sg',       "<cmd> Telescope live_grep<CR>",                 desc = 'Telescope: [S]earch by [G]rep' },
      { '<leader>sk',       "<cmd> Telescope keymaps<CR>",                   desc = 'Telescope: [S]earch [K]eymaps' },
      { '<leader>gf',       "<cmd> Telescope git_files<CR>",                 desc = 'Telescope: Search [G]it [F]iles' },
      { '<leader>sd',       "<cmd> Telescope diagnostics<CR>",               desc = 'Telescope: [S]earch [D]iagnostics' },
      { '<leader>sr',       "<cmd> Telescope resume<CR>",                    desc = 'Telescope: [S]earch [R]esume' },

    },
    config = function()
      local ts = require('telescope')
      local actions = require("telescope.actions")

      ts.setup({
        defaults = {
          winblend = 10,
          path_display = { 'smart' },
          mappings = {
            i = {
              ['<esc>'] = actions.close,
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                            -- the default case_mode is "smart_case"
          }
        },
      })
      ts.load_extension('fzf')

    end,
  },
}
