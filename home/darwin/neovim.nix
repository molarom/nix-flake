{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    extraTSParsers = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      rust
    ];
  };
}
