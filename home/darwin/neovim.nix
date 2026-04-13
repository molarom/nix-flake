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
      rust
    ];
    lspConfig = [
      "lsp.enable('ts_ls')"
    ];
  };
}
