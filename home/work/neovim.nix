{pkgs, ...}: {
  programs.neovim.extraPackages = with pkgs; [
    actionlint
    alejandra # Nix formatter
    clang-tools
    delve
    gopls
    gofumpt
    goimports-reviser
    lua-language-server
    lldb
    nodePackages.typescript-language-server
    prettierd
    nixd # Nix lauguage server
  ];
}
