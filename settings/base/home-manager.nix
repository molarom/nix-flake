{
  inputs,
  outputs,
  ...
}: {
  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
  };
}
