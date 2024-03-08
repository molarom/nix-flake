{ stdenv, fetchurl, makeWrapper, lib
, cups
, dpkg
, a2ps, ghostscript, gnugrep, gnused, coreutils, file, perl, which
}:

stdenv.mkDerivation rec {
  name = "mfcj4335dw-cups-${version}";
  version = "3.5.0.1";

  src = fetchurl {
    url = "https://download.brother.com/welcome/dlf105301/mfcj4335dwpdrv-3.5.0-1.i386.deb";
    sha256 = "14db033672874bca1bea8d778a4b6bce8ab505128ffda66f074ebb5dcb8da9f5";
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ cups ghostscript dpkg a2ps ];

  unpackPhase = ":";

  installPhase = ''
    dpkg-deb -x $src $out

    substituteInPlace $out/opt/brother/Printers/mfcj4335dw/cupswrapper/brother_mfcj4335dw_printer_en.ppd \
      --replace '"Brother MFCJ4335DW' '"Brother MFCJ4335DW (modified)'

    substituteInPlace $out/opt/brother/Printers/mfcj4335dw/lpd/filter_mfcj4335dw \
      --replace /opt "$out/opt" \
      --replace /usr/bin/perl ${perl}/bin/perl \
      --replace "BR_PRT_PATH =~" "BR_PRT_PATH = \"$out\"; #" \
      --replace "PRINTER =~" "PRINTER = \"MFCJ4335DW\"; #"

    # FIXME : Allow i686 and armv7l variations to be setup instead.
    _PLAT=x86_64
    patchelf --set-interpreter $(cat $NIX_CC/nix-support/dynamic-linker) \
      $out/opt/brother/Printers/mfcj4335dw/lpd/$_PLAT/brprintconf_mfcj4335dw
    patchelf --set-interpreter $(cat $NIX_CC/nix-support/dynamic-linker) \
      $out/opt/brother/Printers/mfcj4335dw/lpd/$_PLAT/brmfcj4335dwfilter
    ln -s $out/opt/brother/Printers/mfcj4335dw/lpd/$_PLAT/brprintconf_mfcj4335dw $out/opt/brother/Printers/mfcj4335dw/lpd/brprintconf_mfcj4335dw
    ln -s $out/opt/brother/Printers/mfcj4335dw/lpd/$_PLAT/brmfcj4335dwfilter $out/opt/brother/Printers/mfcj4335dw/lpd/brmfcj4335dwfilter

    for f in \
      $out/opt/brother/Printers/mfcj4335dw/cupswrapper/lpdwrapper \
      $out/opt/brother/Printers/mfcj4335dw/cupswrapper/paperconfigml2 \
    ; do
      #substituteInPlace $f \
      wrapProgram $f \
        --prefix PATH : ${lib.makeBinPath [
          coreutils ghostscript gnugrep gnused
        ]}
    done

    # Hack suggested by samueldr.
    sed -i"" "s;A4;Letter;g" $out/opt/brother/Printers/mfcj4335dw/inf/brmfcj4335dwrc

    mkdir -p $out/lib/cups/filter/
    ln -s $out/opt/brother/Printers/mfcj4335dw/lpd/filter_mfcj4335dw $out/lib/cups/filter/brother_lpdwrapper_mfcj4335dw

    mkdir -p $out/share/cups/model
    ln -s $out/opt/brother/Printers/mfcj4335dw/cupswrapper/brother_mfcj4335dw_printer_en.ppd $out/share/cups/model/

    wrapProgram $out/opt/brother/Printers/mfcj4335dw/lpd/filter_mfcj4335dw \
      --prefix PATH ":" ${ lib.makeBinPath [ ghostscript a2ps file gnused gnugrep coreutils which ] }
    '';

  meta = with lib; {
    homepage = "https://www.brother.com/";
    description = "Brother MFC-J4335DW combined print driver";
    license = licenses.unfree;
    platforms = [
      "x86_64-linux"
    ];
  };
}


