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
      # Work
      black
      nodePackages.typescript-language-server
    ];
    extraTSParsers = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      rust
      latex
      # Work
      css
      hcl
      javascript
      python
      rego
      terraform
      typescript
    ];
    lspConfig = [
      "lspconfig.rust_analyzer.setup{
        on_attach = autoformat -- defined in lsp.lua
      }"
      "lspconfig.texlab.setup{}"
      "lspconfig.ts_ls.setup{}"
    ];
    nullLsSources = [
      "null_ls.builtins.diagnostics.sqlfluff.with({ extra_args = {'--dialect', 'postgres', '-e', 'LT01,LT02,LT05,LT06'}})"
      "null_ls.builtins.formatting.pg_format"
      # Work
      "null_ls.builtins.diagnostics.pylint"
      "null_ls.builtins.diagnostics.regal"
      "null_ls.builtins.formatting.black"
    ];
  };
}
