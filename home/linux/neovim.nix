{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    additionalPackages = with pkgs; [
      texlab
    ];
    lspConfig = [
      "lsp.enable('texlab')"
    ];
  };
}
