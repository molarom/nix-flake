{pkgs, ...}: {
  imports = [
    ../../modules/home/expvarmon
  ];

  home = {
    packages = with pkgs; [
      cmake
      gcc
      gnumake
      go
      python312
    ];
  };
}
