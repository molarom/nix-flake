{pkgs, ...}: {
  imports = [
    ../../modules/home/neovim
  ];

  programs.neovim = {
    enable = true;
    additionalPackages = with pkgs; [
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
      # Disabled for now.
      # "lspconfig.rust_analyzer.setup{
      #   cpa
      #   on_attach = autoformat -- defined in lsp.lua
      # }"
      "lspconfig.ruff.setup{
        on_attach = function(client, bufnr)
          client.server_capabilities.hoverProvider = false
          autoformat(client, bufnr) -- defined in lsp.lua
        end
      }"
      "lspconfig.basedpyright.setup{
        settings = {
          disableOrganizeImports = true,
          analysis = {
            ignore = { '*' },
            typeCheckingMode = 'off',
          }
        }
      }"
      "lspconfig.texlab.setup{}"
    ];
    nullLsSources = [
      "null_ls.builtins.diagnostics.sqlfluff.with({ extra_args = {'--dialect', 'postgres', '-e', 'LT01,LT02,LT05,LT06'}})"
      "null_ls.builtins.formatting.pg_format"
    ];
  };
}
