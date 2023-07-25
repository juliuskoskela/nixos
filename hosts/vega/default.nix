# hosts/vega/default.nix
{
  inputs,
  pkgs,
  ...
}: let
  name = "vega";
in {
  imports = [
    ./hardware-configuration.nix
    # inputs.sops-nix.nixosModules.sops
    (import "${inputs.home-manager}/nixos")
  ];

  nix.buildMachines = [{
    hostName = "awsarm";
    system = "aarch64-linux";
    maxJobs = 4;
    sshUser = "juliuskoskela";
    supportedFeatures = [ "kvm" "benchmark" "big-parallel" "nixos-test" ];
    mandatoryFeatures = [];
    sshKey = "/root/.ssh/unikie-aws-arm";
  }];

  nix.distributedBuilds = true;

  # Install system-wide packages.
  environment = {
    systemPackages = with pkgs; [
      keyd
      python3
      nodejs
      wget
      curl
      pkg-config
      openssl
      helix
      efibootmgr
      nixpkgs-fmt
      cliphist
      gnupg
      ssh-to-pgp
      protonmail-bridge
      hdparm
      pciutils
      pavucontrol
    ];

    variables = {
      WLR_NO_HARDWARE_CURSORS = "1"; # Required so that cursor doesn't disappear
    };
  };

  # Set system state version to the same as the input
  # to ensure that both nixos and home-manager share
  # the same system version (for example "23.05").
  system.stateVersion = inputs.stateVersion;

  # Setup host system boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Additional hardware configuration.
  hardware = {
    bluetooth.enable = true;
    opengl.enable = true;
    opengl.driSupport32Bit = true; # Required for Steam
    pulseaudio.enable = false;
  };

  # Configure nix and nixpkgs.
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config = {
    allowUnfree = true;
    # HACK: Required by nixvim and Copilot, remove if Copilot is udpated
    # to use the new version of nodejs.
    permittedInsecurePackages = [
      "nodejs-16.20.0"
    ];
  };

  # Enable essential services.
  services = {
    xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
    };
    blueman.enable = true;
    printing.enable = true;
    openssh.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  # Networking options. Hostname is set to the name of the host.
  networking = {
    hostName = name;
    networkmanager.enable = true;
  };

  # Time and locale settings.
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

  # Enable Hyprland window manager (Wayland).
  programs.hyprland.enable = true;

  # Enable gnome keyring for KeeWeb etc.
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;

  # Defalt configurations from configuration.nix.
  programs.dconf.enable = true;
  sound.enable = true;
  security.rtkit.enable = true;

  # systemd.user.services.protonmail-bridge = {
  #   enable = true;
  #   description = "ProtonMail Bridge systemd service";
  #   path = [pkgs.gnome.gnome-keyring]; # HACK:
  #   serviceConfig = {
  #     ExecStart = "${pkgs.protonmail-bridge}/bin/protonmail-bridge -n";
  #     WantedBy = ["default.target"];
  #   };
  # };

  # TODO: Configure secrets management
  # https://github.com/Mic92/sops-nix
  # sops.secrets = {
  #   master-key = {};
  # };

  # TODO: Not working currently, start bridge manually.
  # systemd.user.services.protonmail-bridge = {
  #   description = "Protonmail Bridge";
  #   enable = true;
  #   script = "${pkgs.protonmail-bridge}/bin/protonmail-bridge --noninteractive --log-level info";
  #   path = [pkgs.gnome.gnome-keyring]; # HACK: https://github.com/ProtonMail/proton-bridge/issues/176
  #   wantedBy = ["default.target"];
  #   partOf = ["default.target"];
  # };

  # TODO: Use something like this to swap ALT and WIN keys
  # Also check out https://gitlab.com/ajgrf/dotfiles/-/blob/master/nixos/modules/keyboard.nix
  # using kanata.

  #   systemd.services.keyd = {
  #     enable = true;
  #     description = "keyd key remapping daemon";
  #     unitConfig = {
  #       Requires = "local-fs.target";
  #       After = "local-fs.target";
  #     };
  #     serviceConfig = {
  #       Type = "simple";
  #       ExecStart = "${pkgs.keyd}/bin/keyd";
  #     };
  #   };
  #
  #   environment.etc."keyd/default.conf".text = ''
  #     [ids]
  #
  #     *
  #
  #     [main]
  #
  #     # Maps capslock to escape when pressed and control when held.
  #     capslock = overload(control, esc)
  #
  #     # Remaps the escape key to capslock
  #     esc = capslock
  #   '';
}
