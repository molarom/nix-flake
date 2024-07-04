{pkgs, ...}: let
  expvarmon = pkgs.buildGoModule {
    pname = "expvarmon";
    version = "latest";

    src = pkgs.fetchFromGitHub {
      owner = "divan";
      repo = "expvarmon";
      rev = "8e0b3d2";
      hash = "sha256-+dOnks3dUOLrUmV31bwmRACd3SHm1hHO/wabB9IEa0M=";
    };

    vendorHash = null;
  };
in {
  home.packages = [
    expvarmon
  ];
}
