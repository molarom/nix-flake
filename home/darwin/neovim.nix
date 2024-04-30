{
  config,
  pkgs,
  ...
}: {
  programs.neovim.extraPackages = with pkgs; [
    alejandra # Nix formatter
    clang-tools
    delve
    fzf
    gopls
    gofumpt
    goimports-reviser
    lua-language-server
    lldb
    nixd # Nix lauguage server
  ];
}
