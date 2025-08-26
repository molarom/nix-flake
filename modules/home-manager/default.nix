{
  lib,
  config,
  pkgs,
  ...
}: let
  alacritty = import ./alacritty/alacritty.nix {inherit lib config pkgs;};
  expvarmon = import ./expvarmon/expvarmon.nix {inherit lib config pkgs;};
  neovim = import ./neovim/neovim.nix {inherit lib config pkgs;};
in {
  alacritty = alacritty;
  expvarmon = expvarmon;
  neovim = neovim;
}
