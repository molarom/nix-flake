{
  config,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  imports = [
    inputs.home-manager.darwinModules.home-manager
  ];

  users.users.molarom = {
    name = "molarom";
    home = "/Users/molarom";
  };

  # Home Manager
  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    users = {
      "molarom" = import ../../home;
    };
  };

  # Nixpkgs
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Fonts
  fonts.fonts = with pkgs; [
    (nerdfonts.override {fonts = ["Mononoki"];})
  ];

  # System Packages
  environment.systemPackages = with pkgs; [
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
}
