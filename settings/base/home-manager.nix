{
  inputs,
  outputs,
  ...
}: {
  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
  };

  home.file.".zshrc".text = ''
    autoload -U compinit && compinit
  '';
  stateVersion = "23.11";

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  programs.home-manager.enable = true;
}
