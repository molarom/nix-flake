{...}: {
  imports = [
    ../../modules/home/alacrity
  ];

  programs.neovim = {
    enable = true;
    fontSize = 9;
  };
}
