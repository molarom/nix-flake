{
  pkgs,
  options,
  ...
}: {
  programs.neovim = {
    enable = true;
    additionalPackages =
      [
        pkgs.typescript-language-server
        pkgs.prettierd
      ]
      ++ options.programs.neovim.additionalPackages.default;
    extraTSParsers = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      rego
      terraform
    ];
    lspConfig = [
      "lsp.config('basedpyright', {
        settings = {
          basedpyright = {
            disableOrganizeImports = true,
            analysis = {
              ignore = { '*' },
              typeCheckingMode = 'off',
            },
          }
        }
      )"
      "lsp.enable('basedpyright')"
      "lsp.enable('ts_ls')"
    ];
    lintSources =
      [
        "rego = { 'regal' }"
      ]
      ++ options.programs.neovim.lintSources.default;
  };
}
