{pkgs, ...}: {
  imports = [
    ../../modules/home/neovim/neovim.nix
  ];
  programs.neovim = {
    enable = true;
    extraTSParsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [
      css
      hcl
      javascript
      python
      rego
      terraform
      typescript
    ];
    additionalPackages = with pkgs; [
      black
      nodePackages.typescript-language-server
      pgformatter
    ];
    lspConfig = [
      "lspconfig.tsserver.setup{}"
    ];
    nullLsSources = [
      "null_ls.builtins.formatting.black,"
      "null_ls.builtins.formatting.pg_format,"
    ];
  };
}
