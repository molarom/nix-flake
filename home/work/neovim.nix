{pkgs, ...}: {
  imports = [
    ../../modules/neovim/neovim.nix
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
    addtionalLSPs = with pkgs; [
      nodePackages.typescript-language-server
    ];
  };
}
