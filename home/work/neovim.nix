{pkgs, ...}: {
  imports = [
    ../../modules/home/neovim
  ];
  programs.neovim = {
    enable = true;
    extraTSParsers = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      css
      hcl
      javascript
      python
      rego
      terraform
      typescript
    ];
    additionalPackages = with pkgs; [
      actionlint
      ansible-lint
      black
      nodePackages.typescript-language-server
      pgformatter
      pylint
      sqlfluff
    ];
    lspConfig = [
      "lspconfig.tsserver.setup{}"
    ];
    nullLsSources = [
      "null_ls.builtins.diagnostics.actionlint,"
      "null_ls.builtins.diagnostics.ansiblelint,"
      "null_ls.builtins.diagnostics.pylint,"
      "null_ls.builtins.diagnostics.regal,"
      "null_ls.builtins.diagnostics.sqlfluff.with({ extra_args = {'--dialect', 'postgres', '-e', 'CP02,CP05,LT02,LT05,LT06,LT07,LT08,LT09,LT12'}}),"
      "null_ls.builtins.formatting.black,"
      "null_ls.builtins.formatting.pg_format,"
      "null_ls.builtins.formatting.terraform_fmt,"
    ];
  };
}
