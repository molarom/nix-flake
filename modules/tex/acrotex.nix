# AcroTeX EducationBundle - LaTeX package for interactive PDFs
# https://ctan.org/pkg/acrotex
{
  lib,
  stdenvNoCC,
  fetchzip,
  texliveSmall,
}:
stdenvNoCC.mkDerivation {
  pname = "acrotex";
  version = "2021-10-03";

  src = fetchzip {
    url = "https://mirrors.ctan.org/macros/latex/contrib/acrotex.zip";
    hash = "sha256-C01ffp/m4xTiRjE+Q3om3+X2oOR83vyaN1H7V5v5EtA=";
  };

  outputs = ["out" "texdoc" "texsource"];

  nativeBuildInputs = [texliveSmall];

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

    # out: runtime files (TDS structure)
    mkdir -p $out/tex/latex/acrotex
    find . -maxdepth 1 \( -name "*.sty" -o -name "*.def" -o -name "*.cfg" \) -exec cp {} $out/tex/latex/acrotex/ \;

    # texsource output: source files
    mkdir -p $texsource/source/latex/acrotex
    find . -maxdepth 1 \( -name "*.dtx" -o -name "*.ins" \) -exec cp {} $texsource/source/latex/acrotex/ \;

    # texdoc output: documentation
    mkdir -p $texdoc/doc/latex/acrotex
    cp -r doc/* $texdoc/doc/latex/acrotex/ 2>/dev/null || true
    find . -maxdepth 1 -name "README*" -exec cp {} $texdoc/doc/latex/acrotex/ \;

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
