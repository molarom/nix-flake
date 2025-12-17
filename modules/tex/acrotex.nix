# AcroTeX EducationBundle - LaTeX package for interactive PDFs
# https://ctan.org/pkg/acrotex
{
  lib,
  stdenvNoCC,
  fetchzip,
  texliveSmall,
  writeShellScript,
  writableTmpDirAsHomeHook,
}:
stdenvNoCC.mkDerivation {
  pname = "acrotex";
  version = "2021-10-03";

  src = fetchzip {
    url = "https://mirrors.ctan.org/macros/latex/contrib/acrotex.zip";
    hash = "sha256-C01ffp/m4xTiRjE+Q3om3+X2oOR83vyaN1H7V5v5EtA=";
  };

  outputs = ["tex" "texdoc"];

  nativeBuildInputs = [
    (texliveSmall.withPackages (
      ps: [
        ps.hyperref
      ]
    ))
    (writeShellScript "force-tex-output.sh" ''
      out="''${tex-}"
    '')
    writableTmpDirAsHomeHook
  ];

  dontConfigure = true;

  buildPhase = ''
    runHook preBuild

    # Generate .sty files from .ins files
    for ins in *.ins; do
      latex "$ins" || true
    done

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    path="$tex/tex/latex/acrotex"
    mkdir -p "$path"
    find . -maxdepth 1 \( -name "*.sty" -o -name "*.def" -o -name "*.cfg" -o -name "*.clo" -o -name "*.cls" \) -exec cp {} $path \;

    path="$texdoc/doc/latex/acrotex"
    mkdir -p "$path"
    cp -r doc/* $path 2>/dev/null || true
    find . -maxdepth 1 -name "README*" -exec cp {} $path \;

    runHook postInstall
  '';

  passthru = {
    outputSpecified = true;
    tlType = "run";
  };

  meta = {
    description = "The AcroTeX EducationBundle for interactive PDF documents";
    homepage = "https://ctan.org/pkg/acrotex";
    license = lib.licenses.lppl13c;
    maintainers = [];
    platforms = lib.platforms.all;
  };
}
