{pkgs, ...}: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.systemPackages = with pkgs; [
    cowsay
    lolcat
    neovim
  ];

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
    };
    zsh = {
      enable = true;
    };
  };

  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  system.stateVersion = "23.11";
}
