{
  pkgs,
  options,
  ...
}: {
  programs.neovim = {
    enable = true;
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
    ];
    lintSources =
      [
        "rego = { 'regal' }"
      ]
      ++ options.programs.neovim.lintSources.default;
  };
}
