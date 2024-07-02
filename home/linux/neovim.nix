{...}: {
  imports = [
    ../../modules/home/neovim/neovim.nix
  ];

  programs.neovim = {
    enable = true;
    nullLsSetup = ''
      asdf
    '';
  };
}
