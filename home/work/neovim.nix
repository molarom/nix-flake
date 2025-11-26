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
      ]
      ++ options.programs.neovim.additionalPackages.default;
    extraTSParsers = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      rego
      terraform
    ];
    lspConfig = [
      "lsp.config('ts_ls')"
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
    ];
    lintSources =
      [
        "rego = { 'regal' }"
      ]
      ++ options.programs.neovim.lintSources.default;
  };
}
