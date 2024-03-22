{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./base
    ./neovim
  ];
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    file.".zshrc".text = ''
      autoload -U compinit && compinit
    '';
    stateVersion = "23.11";
  };

  programs.ssh = {
    enable = true;
    extraOptionOverrides = {
      AddKeysToAgent = "yes";
      IdentitiesOnly = "yes";
    };
  };

  programs.home-manager.enable = true;
}
