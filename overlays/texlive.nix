final: prev: let
  texModules = import ../modules/tex;
  acrotexPkg = prev.callPackage texModules.acrotex {};
in {
  texlive = prev.texlive // {
    pkgs = prev.texlive.pkgs // {
      acrotex = acrotexPkg;
    };
  };

  # Override texliveBasic.withPackages to include custom packages
  texliveBasic = prev.texliveBasic.overrideAttrs (old: {
    passthru = old.passthru // {
      withPackages = f: old.passthru.withPackages (ps: f (ps // {
        acrotex = acrotexPkg;
      }));
    };
  });
}
