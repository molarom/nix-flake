{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.programs.neovim;

  ##################################################################
  # Trash tool for Nvim-Tree
  ##################################################################

  trash_cmd =
    if pkgs.system == "aarch64-darwin"
    then pkgs.darwin.trash
    else pkgs.trash-cli;

  ##################################################################
  # Telescope fzf
  ##################################################################

  telescope-fzf = pkgs.vimPlugins.telescope-fzf-native-nvim;

  ##################################################################
  # Treesitter
  ##################################################################

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
        p.luadoc
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
    ##################################################################
    # Files
    ##################################################################

    home.packages = [
      trash_cmd
    ];

    ##################################################################
    # Files
    ##################################################################

    home.file."./.config/nvim/" = {
      source = ./nvim;
      recursive = true;
    };

    home.file."./.local/share/nvim/nix/telescope-fzf-native/" = {
      source = telescope-fzf;
      recursive = true;
    };

    home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
      source = treesitterWithGrammars;
      recursive = true;
    };

    home.file."./.config/nvim/init.lua" = {
      text = ''
        local csName = "${cfg.colorscheme}"

        require("config")
        require("plugin-loader")

        local ok, _ = pcall(require, "plugins.themes." .. csName)
        if(not ok) then
          error("Unable to load theme: " .. csName .. " double check the lua/plugins/themes module.")
        else
          vim.cmd.colorscheme(csName)
        end

        vim.opt.runtimepath:append("${treesitter-parsers}")
        vim.opt.runtimepath:append("${telescope-fzf}")
      '';
    };

    home.file."./.config/nvim/lua/plugins/lsp.lua" = {
      text = ''
        -- LSP configs
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        return {
          {
            "nvimtools/none-ls.nvim",
            event = "VeryLazy",
            dependencies = {
              { "nvim-lua/plenary.nvim" },
            },
            config = function()
              local null_ls = require("null-ls")
              null_ls.setup({
                sources = {
                  null_ls.builtins.formatting.clang_format,
                  null_ls.builtins.formatting.gofumpt,
                  null_ls.builtins.formatting.goimports_reviser,
                  null_ls.builtins.formatting.alejandra,
                  ${(lib.concatStringsSep "\n" cfg.nullLsSources)}
                },
                on_attach = function(client, bufnr)
                  if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({
                      group = augroup,
                      buffer = bufnr,
                    })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                      group = augroup,
                      buffer = bufnr,
                      callback = function()
                        vim.lsp.buf.format({ bufnr = bufnr })
                      end,
                    })
                  end
                end
              })
            end,
          },
          {
            'neovim/nvim-lspconfig',
            cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
            event = { 'BufReadPre', 'BufNewFile' },
            dependencies = {
              { 'hrsh7th/cmp-nvim-lsp' },
              { 'nvimtools/none-ls.nvim' },
            },
            config = function()
              local lspconfig = require("lspconfig")

              local cmp_lsp = require('cmp_nvim_lsp')
              local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities())

              lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
                capabilities = capabilities,
                on_attach = require("config.lsp_keymaps"),
              })

              lspconfig.lua_ls.setup {
                settings = {
                  Lua = {
                      diagnostics = {
                          globals = { "vim", "it", "describe", "before_each", "after_each" },
                      }
                  }
                }
              }
              lspconfig.nixd.setup {}
              lspconfig.gopls.setup {}
              lspconfig.clangd.setup {}
              ${(lib.concatStringsSep "\n" cfg.lspConfig)}

            end,
          }
        }
      '';
    };
  };

  ##################################################################
  # Options
  ##################################################################

  options.programs.neovim = {
    additionalPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "additional packages to install, typically LSPs";
    };

    colorscheme = lib.mkOption {
      type = lib.types.nullOr (lib.types.enum ["tokyonight" "catppuccin"]);
      default = "tokyonight";
      description = ''
        the colorscheme to set

        must be one of "tokyonight, catppuccin" (default "tokyonight")
      '';
    };

    extraTSParsers = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "addtional treesitter parsers to install";
    };

    lspConfig = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "additional lines to pass to 'lspconfig.setup()'";
    };

    nullLsSources = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "additional lines to pass to 'null_ls.setup()'";
    };
  };

  ##################################################################
  # Config
  ##################################################################

  config.programs.neovim = lib.mkIf cfg.enable {
    defaultEditor = lib.mkDefault true;
    viAlias = lib.mkDefault true;
    vimAlias = lib.mkDefault true;
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
        trash_cmd
      ]
      ++ cfg.additionalPackages;
    plugins = [
      telescope-fzf
      treesitterWithGrammars
    ];
  };
}
