{
  config,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  users.users.molarom = {
    name = "molarom";
    home = "/Users/molarom";
  };

  # Fonts
  fonts.fonts = with pkgs; [
    (nerdfonts.override {fonts = ["Mononoki"];})
  ];

  # System Packages
  environment.systemPackages = with pkgs; [
  ];

  # nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
