###############################################################################
#
# Main NixOS configuration file

{ config, pkgs, home-manager, ...}:
{
  imports = [
    ./hardware-configuration.nix
    (import "${home-manager}/nixos")
  ];

  ###########################################################################
  #
  # System, hardware and boot

  system.stateVersion = state-version;
  hardware = {
    bluetooth.enable = true;
    opengl.driSupport32Bit = true; # Required for Steam
    pulseaudio.enable = false;
  };
  boot.loader = {
    timeout = 30;
    efi = {
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      theme = pkgs.nixos-grub2-theme;
      efiSupport = true;
      efiInstallAsRemovable = true; # Otherwise /boot/EFI/BOOT/BOOTX64.EFI isn't generated
      devices = [ "nodev" ];
      useOSProber = true;
      extraEntries = ''
        		menuentry "Reboot" {
        			reboot
        		}
        		menuentry "Poweroff" {
        			halt
        		}
        		'';
    };
  };


  ###########################################################################
  #
  # Nix

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config = {
    allowUnfree = true;
    # TODO! Required by nixvim and Copilot, remove if Copilot is udpated
    # to use the new version of nodejs.
    permittedInsecurePackages = [
      "nodejs-16.20.0"
    ];
  };

  ###########################################################################
  #
  # Users

  users.users = {
    juliuskoskela = {
      isNormalUser = true;
      description = "Julius Koskela";
      extraGroups = [ "networkmanager" "wheel" ];
    };
    juliuskoskela-unikie = {
      isNormalUser = true;
      description = "Julius Koskela (Unikie)";
      extraGroups = [ "networkmanager" "wheel" ];
    };
  };
  home-manager.users = {
    juliuskoskela = import ./users/juliuskoskela { inherit state-version config pkgs; };
    juliuskoskela-unikie = import ./users/juliuskoskela-unikie { inherit state-version config pkgs; };
  };

  ###########################################################################
  #
  # Services

  services = {
    blueman.enable = true;
    xserver = import ./programs/desktop/gnome.nix { inherit config pkgs; };
    printing.enable = true;
    openssh.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  ###########################################################################
  #
  # Networking

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  ###########################################################################
  #
  # Time and locale

  time = {
    timeZone = "Europe/Helsinki";
  };
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "fi_FI.UTF-8";
      LC_IDENTIFICATION = "fi_FI.UTF-8";
      LC_MEASUREMENT = "fi_FI.UTF-8";
      LC_MONETARY = "fi_FI.UTF-8";
      LC_NAME = "fi_FI.UTF-8";
      LC_NUMERIC = "fi_FI.UTF-8";
      LC_PAPER = "fi_FI.UTF-8";
      LC_TELEPHONE = "fi_FI.UTF-8";
      LC_TIME = "fi_FI.UTF-8";
    };
  };

  ###########################################################################
  #
  # Programs

  programs = {
    dconf.enable = true;
  };

  ###########################################################################
  #
  # Sound

  sound.enable = true;

  ###########################################################################
  #
  # Security

  security.rtkit.enable = true;

  ###########################################################################
  #
  # Root environment

  environment = {
    systemPackages = with pkgs; [
      # neovim
      python3
      nodejs
      wget
      curl
      pkg-config
      openssl
      helix
      efibootmgr
      nixpkgs-fmt
    ];
  };
}
