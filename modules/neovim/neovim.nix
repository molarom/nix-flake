{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.programs.neovim;

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
      ++ cfg.extraTSParsers
  );

  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = treesitterWithGrammars.dependencies;
  };
in {
  config = {
    home.file."./.config/nvim/" = {
      source = ./nvim;
      recursive = true;
    };

    home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
      source = treesitterWithGrammars;
      recursive = true;
    };

    home.file."./.config/nvim/init.lua" = {
      text = ''
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
    };
  };
  options.programs.neovim = {
    additionalLSPs = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "additional packages to install, typically LSPs";
    };

    extraTSParsers = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      description = "addtional treesitter parsers to install";
    };
  };
  config.programs.neovim = lib.mkIf cfg.enable {
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
      ++ cfg.additionalLSPs;
    plugins = [
      treesitterWithGrammars
    ];
  };
}
#vim.opt.runtimepath:append("${(.file.mkOutOfStoreSymlink {source = cfg.treesitterWithGrammars.dependencies;})}")
