{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.programs.neovim;

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

  home.file."./.config/nvim/lsp-testing.lua" = {
    text = ''
      -- LSP configs
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      return {
        {
          'williamboman/mason.nvim',
          lazy = false,
          config = true,
        },
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
                ${cfg.nullLsSetup}
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
            { 'williamboman/mason-lspconfig.nvim' },
            { 'jay-babu/mason-null-ls.nvim' },
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


            -- this will be removed eventually.
            require('mason-lspconfig').setup({
              ensure_installed = {},
              handlers = {
                function(server_name)
                  require("lspconfig")[server_name].setup {
                    capabilities = capabilities,
                    on_attach = require("config.lsp_keymaps"),
                  }
                end,
              },
          })
          end,
        }
      }
    '';
  };

  ##################################################################
  # Options
  ##################################################################

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

    nullLsSetup = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "addtional lines to provide to 'null_ls.setup()'";
    };
  };
  config.programs.neovim = lib.mkIf cfg.enable {
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
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
