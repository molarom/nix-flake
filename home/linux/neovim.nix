{pkgs, ...}: {
  imports = [
    ../../modules/home/neovim
  ];

  programs.neovim = {
    enable = true;
    extraTSParsers = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      latex
    ];
    additionalPackages = with pkgs; [
      texlab
    ];
    lspConfig = [
      "lspconfig.texlab.setup{}"
    ];
  };
}
