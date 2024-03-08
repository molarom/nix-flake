# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, outputs, ... }:

{
  imports =
    [ 
      inputs.home-manager.nixosModules.home-manager

      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  # Enable Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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
     xsel
  ];

  # Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = ["Mononoki"]; })
  ];

  users.users.bepperson = {
    isNormalUser = true;
    description = "Brandon";
    extraGroups = [ "networkmanager" "wheel" ];
    openssh.authorizedKeys.keys = [
    ];
    shell = pkgs.zsh;
  };

  # Home Manager
  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      "bepperson" = import ./home.nix;
    };
  };

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
      layout = "us";
      xkbVariant = "";
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
  environment.shells = with pkgs; [ zsh ];

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
    # firewall.allowedTCPPorts = [ 8001 ];
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
    packages = [ pkgs.terminus_font ];
    font = "${pkgs.terminus_font}/share/consolefonts/ter-i22b.psf.gz";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
