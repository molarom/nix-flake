{pkgs, ...}: let
  treesitterWithGrammars = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    p.bash
    p.c
    p.cpp
    p.dockerfile
    p.gitattributes
    p.gitignore
    p.go
    p.gomod
    p.jq
    p.lua
    p.make
    p.markdown
    p.nix
    p.sql
    p.toml
    p.vim
    p.vimdoc
    p.yaml
  ]);
  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = treesitterWithGrammars.dependencies;
  };
in {
  programs.neovim = {
    extraPackages = with pkgs; [
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
    plugins = [
      treesitterWithGrammars
    ];
  };

  home.file."./.config/nvim/" = {
    source = ./nvim;
    recursive = true;
  };

  home.file."./.config/nvim/init.lua".text = ''
    local csName = "tokyonight"

    require("config")
    require("plugin-loader")

    local ok, _ = pcall(require, "plugins.themes." .. csName)
    if(not ok) then
      error("Unable to load theme: " .. csName .. " double check the lua/plugins/themes module.")
    else
      vim.cmd.colorscheme(csName)
    end

    vim.opt.runtimepath:append("${treesitter-parsers}")
  '';

  home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
    source = treesitterWithGrammars;
    recursive = true;
  };
}
