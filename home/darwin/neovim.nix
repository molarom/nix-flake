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
        pkgs.svelte-language-server
      ]
      ++ options.programs.neovim.additionalPackages.default;
    extraTSParsers = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      rust
      svelte
      scss
    ];
    lspConfig = [
      "lsp.enable('ts_ls')"
      "lsp.enable('svelte')"
    ];
    extraPython3Packages = p: [
      p.pylatexenc
    ];
  };
}
