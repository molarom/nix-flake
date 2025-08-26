{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    additionalPackages = with pkgs; [
      typescript-language-server
      prettierd
      pgformatter
      sqlfluff
    ];
    extraTSParsers = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      css
      hcl
      javascript
      python
      rego
      terraform
      typescript
    ];
    lspConfig = [
      "lspconfig.ts_ls.setup{}"
      "lspconfig.ruff.setup{
        on_attach = function(client, bufnr)
          client.server_capabilities.hoverProvider = false
          autoformat(client, bufnr) -- defined in lsp.lua
        end
      }"
      "lspconfig.basedpyright.setup{
        settings = {
          basedpyright = {
            disableOrganizeImports = true,
            analysis = {
              ignore = { '*' },
              typeCheckingMode = 'off',
            },
          }
        }
      }"
    ];
    nullLsSources = [
      "null_ls.builtins.code_actions.gitsigns"
      "null_ls.builtins.diagnostics.regal"
      "null_ls.builtins.diagnostics.sqlfluff.with({ extra_args = {'--dialect', 'postgres', '-e', 'CP02,CP05,LT02,LT05,LT06,LT07,LT08,LT09,LT12'}})"
      "null_ls.builtins.formatting.pg_format"
      "null_ls.builtins.formatting.terragrunt_fmt"
      "null_ls.builtins.formatting.prettierd.with({
        filetypes = {         
          'javascript',
          'javascriptreact',
          'typescript',
          'typescriptreact', 
          'html', 
          'json', 
          'yaml', 
          'markdown', 
          'toml' 
        },
      })"
    ];
  };
}
