{pkgs, ...}: {
  imports = [
    ../../modules/home/neovim/neovim.nix
  ];

  programs.neovim = {
    enable = true;
    extraTSParsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [
      ruby
    ];
  };
}
