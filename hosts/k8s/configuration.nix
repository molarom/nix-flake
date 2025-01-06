{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    neovim
  ];

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
  };

  system.stateVersion = "23.11";
}
