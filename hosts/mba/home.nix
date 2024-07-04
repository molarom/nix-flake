{
  inputs,
  outputs,
  ...
}: {
  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    users = {
      "molarom" = import ./home/darwin;
    };
  };
}
