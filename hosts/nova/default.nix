# Nova
#
# Desktop PC system.
{
  inputs,
  config,
  pkgs,
  stateVersion,
  ...
}: let
  name = "nova";
  users = import ../../users;
in {
  imports = [
    ./hardware-configuration.nix
    (import "${inputs.home-manager}/nixos")
	# ../../programs/hyprland
  ];

  ###########################################################################
  #
  # System, hardware and boot

  system.stateVersion = stateVersion;

#   monitors = [
#     {
#       name = "DP-1";
#       width = 2560;
#       height = 1440;
#       x = 0;
#       workspace = "1";
#     }
#     {
#       name = "DP-2";
#       width = 2560;
#       height = 1440;
#       noBar = true;
#       x = 1440;
#       workspace = "2";
#     }
#   ];

  ###########################################################################
  #
  # Nix

  nix.settings.experimental-features = ["nix-command" "flakes"];
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
    juliuskoskela = users.juliuskoskela.user;
    # juliuskoskela-unikie = users.juliuskoskela-unikie.user;
  };

  home-manager.users = {
    juliuskoskela = users.juliuskoskela.home {inherit inputs pkgs stateVersion;};
    # juliuskoskela-unikie = users.juliuskoskela-unikie.home {inherit pkgs stateVersion;};
  };

  ###########################################################################
  #
  # Services

  services = {
    blueman.enable = true;
    xserver = import ../../programs/desktop/gnome.nix {inherit config pkgs;};
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
    hostName = name;
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
