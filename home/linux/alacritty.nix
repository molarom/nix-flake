{...}: {
  imports = [
    ../../modules/home/alacritty
  ];

  programs.alacritty = {
    enable = true;
    fontSize = 9.25;
  };
}
