{
  lib,
  config,
  pkgs,
  ...
}: let
  ##################################################################
  # Module globals
  ##################################################################
  cfg = config.programs.neovim;

  # lists module.
  lists = pkgs.lib.romalor.lists;

  nvim_plugins_dir = "./.config/nvim/lua/plugins";

  ##################################################################
  # Trash tool for Nvim-Tree
  ##################################################################

  trash_cmd =
    if pkgs.system == "aarch64-darwin"
    then pkgs.darwin.trash
    else pkgs.trash-cli;

  ##################################################################
  # Image paste tool for img-clip.
  ##################################################################

  image_clip_cmd =
    if pkgs.system == "aarch64-darwin"
    then pkgs.pngpaste
    else pkgs.xclip;

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
        p.css
        p.dockerfile
        p.gitattributes
        p.gitignore
        p.go
        p.gomod
        p.javascript
        p.json
        p.jq
        p.latex
        p.lua
        p.luadoc
        p.make
        p.markdown
        p.markdown_inline
        p.python
        p.nix
        p.sql
        p.typescript
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

    # -- Formatting
    home.file."${nvim_plugins_dir}/comform.lua" = {
      text = ''
        return {
          "stevearc/conform.nvim",
          event = { "BufReadPre", "BufNewFile" },
          cmd = { "ConformInfo" },
          keys = {
            {
              -- Customize or remove this keymap to your liking
              "<leader>f",
              function()
                require("conform").format({ async = true })
              end,
              mode = { "n", "v" },
              desc = "[F]ormat buffer",
            },
          },
          config = function()
            local conform = require("conform")

            conform.setup({
              formatters_by_ft = {
                javascript = { "prettierd" },
                typescript = { "prettierd" },
                javascriptreact = { "prettierd" },
                typescriptreact = { "prettierd" },
                markdown = { "prettierd", "injected" },
                css = { "prettierd" },
                html = { "djlint", "prettierd" },
                json = { "prettierd" },
                yaml = { "prettierd" },
                nix = { "alejandra" },
                c = { "clang-format" },
                go = { "golangci-lint", "injected" },
                sql = { "pg_format" },
                python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
                c = { "clang-format" },
                ["_"] = {"trim_whitespace"},
              },
              format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 500,
              },
            })
          end,
        }
      '';
    };

    # -- Lint

    home.file."${nvim_plugins_dir}/nvim-lint.lua" = {
      text = ''
        -- asynchronous linting
        return {
          "mfussenegger/nvim-lint",
          event = {
            "BufReadPre",
            "BufNewFile",
          },
          keys = {
            { '<leader>l', '<cmd> lua require("lint").try_lint()<CR>', desc = '[L]int' },
          },
          config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
              javascript = { "eslint_d" },
              typescript = { "eslint_d" },
              javascriptreact = { "eslint_d" },
              typescriptreact = { "eslint_d" },
              go = { "golangcilint" },
              c = { "clang-tidy" },
            }

            local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

            vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
              group = lint_augroup,
              callback = function()
                lint.try_lint()
              end,
            })
          end,
        }
      '';
    };

    # -- LSP

    home.file."${nvim_plugins_dir}/lsp.lua" = {
      text = ''
        -- LSP configs
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        -- Autoformatting
        local autoformat = function(client, bufnr)
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

        return {
          {
            'neovim/nvim-lspconfig',
            cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
            event = { 'BufReadPre', 'BufNewFile' },
            keys = {
              { '<leader>rn', "<cmd> lua vim.lsp.buf.rename<CR>",      desc = 'LSP: [R]e[N]ame' },
              { '<leader>ca', "<cmd> lua vim.lsp.buf.code_action<CR>", desc = 'LSP: [C]ode [A]ction' },
            },
            dependencies = {
              { 'hrsh7th/cmp-nvim-lsp' },
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
              ${(lists.formatStringList cfg.lspConfig "\n" 6)}
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
        pkgs.djlint
        pkgs.eslint_d
        pkgs.fzf
        pkgs.golangci-lint
        pkgs.gopls
        pkgs.lldb
        pkgs.lua-language-server
        pkgs.nixd # Nix lauguage server
        pkgs.pgformatter
        pkgs.prettierd
        pkgs.stylua
        pkgs.typescript-language-server
        image_clip_cmd
        trash_cmd
      ]
      ++ cfg.additionalPackages;
    plugins = [
      telescope-fzf
      treesitterWithGrammars
    ];
  };
}
