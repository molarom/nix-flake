{nvim-treesitter-src}: final: prev: {
  vimPlugins = prev.vimPlugins.extend (vimFinal: vimPrev: {
    nvim-treesitter = vimPrev.nvim-treesitter.overrideAttrs (oldAttrs: {
      version = "master-${nvim-treesitter-src.shortRev or "unknown"}";
      src = nvim-treesitter-src;
    });
  });
}
