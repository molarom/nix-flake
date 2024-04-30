# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # System packages
  environment.systemPackages = with pkgs; [
    git
    jq
    neofetch
    openssl
    parallel
    pcsctools
    qemu
    sshpass
    virt-manager
    virtio-win
    xsel
  ];

  # Programs
  programs = {
    zsh.enable = true;
    virt-manager.enable = true;
  };

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["Mononoki"];})
  ];

  users.users.bepperson = {
    isNormalUser = true;
    description = "Brandon";
    extraGroups = ["networkmanager" "wheel"];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCtfZlG+Kvde5chORBhjFxo3H0yl1LKiC5QvyTWJyDT05RMV7d6WgUyMOdK3qbufKETLUq37Shs+nTyBQ9G5vCYT1aPe569R+gZf9u5365YvkOd1OJFFfQ3rtSpfIukqjtH4WF7x4d6/8/prepKt/lKefnRIJV9wZg4LpFyTyR9kR2hM/NodlZnQm05Gnckt2yj6XkCf5OF/u7kR7dbmJ6pzQzW+pGyYdPm0PHtJ/U2XN/NjYaLTYjI1gs59QsS0ab159LpuZlDhMFeBrJ2OJQy29IMWxwDu9tf+pwCtFFJlqGpu6TqBmpn9mH/P/9lkYcVGjN/HUFhv2q7c34CLvU8SRBR2fn9V+bfRT14z+o6ZXn+OohdMNlJtlbm5+RdnAxFq5XKWDjS5yVfQJaNPziyeQJBl5krqUdaumjCNvoVVEUy86HwF02y1iVm5Xyfk0OermfNjQmHLMwKVNyamEOWV6hY48gKVE/4mgnaXOTFJDrdA/JxcBQY7MsBapFCql/aaUDgmtjltNMzIbQxVdISZvH1xMlRQTetMnTk/ipVJWMAvOtoacJoeou0wh2nsqOrpadQDuSN9vR2ILK7h2g/eJwN/X/XeAx2aMOzGUSGnetSxs+CJPmZ0WVSyKu+9KqR7Zl2WBeKztSUmgXiDCjX6JVycrzLPHz++PsuLbJj1w== molarom@mba"
    ];
    shell = pkgs.zsh;
  };

  # Home Manager

  # List services that you want to enable:
  services = {
    # Enable the OpenSSH daemon.
    openssh = {
      enable = true;
      settings = {
        X11Forwarding = true;
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
      openFirewall = true;
    };

    # Enable smartcards
    pcscd = {
      enable = true;
    };

    # Enable sound with pipewire.
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    # Enable CUPS to print documents.
    printing = {
      enable = true;
    };

    # Enable the Pantheon Desktop Environment.
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      displayManager = {
        lightdm.enable = true;
      };
      desktopManager = {
        pantheon = {
          enable = true;
          extraGSettingsOverrides = ''
            [io.elementary.terminal.settings]
            font='Mononoki Nerd Font 10'
            follow-last-tab=true
          '';
          extraGSettingsOverridePackages = [
            pkgs.pantheon.elementary-terminal
          ];
        };
      };
    };
  };

  # Add zsh to /etc/shells.
  environment.shells = with pkgs; [zsh];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Networking
  networking = {
    hostName = "nixos"; # Define your hostname.
    networkmanager.enable = true;

    # Open ports in the firewall.
    firewall.allowedTCPPorts = [
      22
      8080
    ];
  };

  # Sound settings
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  # Time zone
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };
  console = {
    packages = [pkgs.terminus_font];
    font = "${pkgs.terminus_font}/share/consolefonts/ter-i22b.psf.gz";
  };

  # Virtualisation settings
  virtualisation = {
    libvirtd.enable = true;
    # vmware.host.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
