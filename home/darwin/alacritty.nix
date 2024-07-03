{...}: {
  imports = [
    ../../modules/home/alacritty
  ];

  programs.alacritty = {
    enable = true;
    fontOffset = "{ x = 2, y = 2 }";
  };
}
