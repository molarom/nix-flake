{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
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
      // cfg.extraTSParsers
  );

  treesitter-parsers = lib.symlinkJoin {
    name = "treesitter-parsers";
    paths = cfg.treesitterWithGrammars.dependencies;
  };

  lib.file."./.config/nvim/" = {
    source = ./nvim;
    recursive = true;
  };

  lib.file."./.local/share/nvim/nix/nvim-treesitter/" = {
    source = cfg.treesitterWithGrammars;
    recursive = true;
  };

  lib.file."./.config/nvim/init.lua" = {
    inherit cfg;
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
in {
  options.programs.neovim = {
    addtionalLSPs = mkOption {
      type = types.listOf types.package;
      description = "additional packages to install, typically LSPs";
    };

    extraTSParsers = mkOption {
      type = types.listOf types.package;
      description = "addtional treesitter parsers to install";
    };
  };
  config.programs.neovim = mkIf cfg.enable {
    extraPackages =
      [
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
      ]
      // cfg.additionalLSPs;
    plugins = [
      treesitterWithGrammars
    ];
  };
}
#vim.opt.runtimepath:append("${(.file.mkOutOfStoreSymlink {source = cfg.treesitterWithGrammars.dependencies;})}")
