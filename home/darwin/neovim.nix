{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    additionalPackages = with pkgs; [
      texlab
    ];
    extraTSParsers = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      rust
    ];
    lspConfig = [
      # Disabled for now.
      # "lspconfig.rust_analyzer.setup{
      #   cpa
      #   on_attach = autoformat -- defined in lsp.lua
      # }"
      "lspconfig.ts_ls.setup{}"
      "lspconfig.ruff.setup{}"
      "lspconfig.texlab.setup{}"
    ];
  };
}
