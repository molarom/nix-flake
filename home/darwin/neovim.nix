{pkgs, ...}: {
  imports = [
    ../../modules/home/neovim
  ];

  programs.neovim = {
    enable = true;
    additionalPackages = with pkgs; [
      rust-analyzer
      pgformatter
      sqlfluff
      texlab
    ];
    extraTSParsers = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      rust
      latex
      css
      python
    ];
    lspConfig = [
      "lspconfig.rust_analyzer.setup{
        on_attach = autoformat -- defined in lsp.lua
      }"
      "lspconfig.basedpyright.setup{
        -- testing defaults first
        -- analysis = {
        --   autoSearchPaths = true,
        --   diagnosticMode = 'openFilesOnly',
        --   useLibraryCodeForTypes = true
        -- }
      }"
      "lspconfig.ruff.setup{
        on_attach = autoformat
      }"
      "lspconfig.texlab.setup{}"
    ];
    nullLsSources = [
      "null_ls.builtins.diagnostics.sqlfluff.with({ extra_args = {'--dialect', 'postgres', '-e', 'LT01,LT02,LT05,LT06'}})"
      "null_ls.builtins.formatting.pg_format"
    ];
  };
}
