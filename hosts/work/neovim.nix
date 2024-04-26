{
  config,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraPackages = with pkgs; [
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
  };
}
