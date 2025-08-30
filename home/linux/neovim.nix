{pkgs, ...}: {
  imports = [
    ../../modules/home/neovim
  ];

  programs.neovim = {
    enable = true;
    additionalPackages = with pkgs; [
      texlab
    ];
    lspConfig = [
      "lspconfig.texlab.setup{}"
    ];
  };
}
