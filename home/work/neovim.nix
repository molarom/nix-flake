{pkgs, ...}: {
  home.file."./.local/share/nvim/lazy/nvim-treesitter/" = {
    recursive = true;
    source = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
  };
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
