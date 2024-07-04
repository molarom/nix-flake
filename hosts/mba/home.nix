{
  inputs,
  outputs,
  ...
}: {
  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    users = {
      "brandon" = import ../../home/work;
    };
  };
}
