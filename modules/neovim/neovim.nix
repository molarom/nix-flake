{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.lazyNeovim;
in {
  options.neovim = {
    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      description = "additional packages to install, typically LSPs";
    };

    extraTSParsers = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      description = "addtional treesitter parsers to install";
    };
  };
  config = {
    treesitterWithGrammars = pkgs.vimPlugins.nvim-treesitter.withPlugins (
      p:
        [
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
        ]
        // cfg.extraTSParsers
    );
    programs.neovim = {
      extraPackages =
        [
          pkgs.alejandra # Nix formatter
          pkgs.clang-tools
          pkgs.delve
          pkgs.fzf
          pkgs.gopls
          pkgs.gofumpt
          pkgs.goimports-reviser
          pkgs.lua-language-server
          pkgs.lldb
          pkgs.nixd # Nix lauguage server
        ]
        // cfg.extraPackages;
      plugins = [
        config.treesitterWithGrammars
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

      vim.opt.runtimepath:append("${cfg.treesitter-parsers}")
    '';

    home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
      source = cfg.treesitterWithGrammars;
      recursive = true;
    };
    treesitter-parsers = pkgs.symlinkJoin {
      name = "treesitter-parsers";
      paths = cfg.treesitterWithGrammars.dependencies;
    };
  };
}
