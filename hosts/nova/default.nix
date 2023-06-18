# hosts/nova/default.nix
{inputs, ...}: let
  name = "nova";
in {
  imports = [
    ./hardware-configuration.nix
    (import "${inputs.home-manager}/nixos")
    ../../kven/programs/gnome
    ../../users/juliuskoskela
  ];

  system.stateVersion = inputs.stateVersion;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config = {
    allowUnfree = true;
    # TODO! Required by nixvim and Copilot, remove if Copilot is udpated
    # to use the new version of nodejs.
    permittedInsecurePackages = [
      "nodejs-16.20.0"
    ];
  };

  services = {
    blueman.enable = true;
    # xserver = import ../../programs/desktop/gnome.nix {inherit config pkgs;};
    printing.enable = true;
    openssh.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  networking = {
    hostName = name;
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Helsinki";
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

  programs.dconf.enable = true;
  sound.enable = true;
  security.rtkit.enable = true;
  environment = {
    systemPackages = with inputs.nixpkgs; [
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
