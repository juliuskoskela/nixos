# hosts/vega/default.nix
{
  inputs,
  pkgs,
  ...
}: let
  name = "vega";
  microvm = inputs.microvm.nixosModules;
in {
  imports = [
    ./hardware-configuration.nix
    (import "${inputs.home-manager}/nixos")
    microvm.host
  ];

  microvm.vms = {
    vm-1 = {
      # The package set to use for the microvm. This also determines the microvm's architecture.
      # Defaults to the host system's package set if not given.
      inherit pkgs;

      # (Optional) A set of special arguments to be passed to the MicroVM's NixOS modules.
      #specialArgs = {};

      # The configuration for the MicroVM.
      # Multiple definitions will be merged as expected.
      config = {
        # It is highly recommended to share the host's nix-store
        # with the VMs to prevent building huge images.
        microvm = {
          shares = [
            {
              source = "/nix/store";
              mountPoint = "/nix/.ro-store";
              tag = "ro-store";
              proto = "virtiofs";
            }
          ];

          interfaces = [
            {
              type = "tap";
              id = "vm-test1";
              mac = "02:00:00:00:00:01";
            }
          ];
        };

        users.users.root.password = "root";

        systemd.network.enable = true;

        systemd.network.networks."20-lan" = {
          matchConfig.Type = "ether";
          networkConfig = {
            Address = ["192.168.1.3/24" "2001:db8::b/64"];
            Gateway = "192.168.1.1";
            DNS = ["192.168.1.1"];
            IPv6AcceptRA = true;
            DHCP = "no";
          };
        };

        services.openssh = {
          enable = true;
          settings.PermitRootLogin = "yes";
        };
      };
    };
  };

  microvm.autostart = ["vm-1"];

  systemd.network.enable = true;

  systemd.network.networks."10-lan" = {
    matchConfig.Name = ["eno1" "vm-*"];
    networkConfig = {
      Bridge = "br0";
    };
  };

  systemd.network.netdevs."br0" = {
    netdevConfig = {
      Name = "br0";
      Kind = "bridge";
    };
  };

  systemd.network.networks."10-lan-bridge" = {
    matchConfig.Name = "br0";
    networkConfig = {
      Address = ["192.168.1.2/24" "2001:db8::a/64"];
      Gateway = "192.168.1.1";
      DNS = ["192.168.1.1"];
      IPv6AcceptRA = true;
    };
    linkConfig.RequiredForOnline = "routable";
  };

  nix = {
    settings.experimental-features = ["nix-command" "flakes"];

    buildMachines = [
      {
        hostName = "awsarm";
        system = "aarch64-linux";
        maxJobs = 32;
        sshUser = "juliuskoskela";
        supportedFeatures = ["kvm" "benchmark" "big-parallel" "nixos-test"];
        mandatoryFeatures = [];
        sshKey = "/root/.ssh/unikie-aws-arm";
      }
    ];

    distributedBuilds = true;
  };

  # Configure nix and nixpkgs.
  nixpkgs.config = {
    allowUnfree = true;
    # HACK: Required by nixvim and Copilot, remove if Copilot is udpated
    # to use the new version of nodejs.
    permittedInsecurePackages = [
      "nodejs-16.20.0"
    ];
  };

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

  # Setup host system boot loader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  # Additional hardware configuration.
  hardware = {
    bluetooth.enable = true;
    opengl.enable = true;
    opengl.driSupport32Bit = true; # Required for Steam
    pulseaudio.enable = false;
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

    # Enable gnome keyring for KeeWeb etc.
    gnome.gnome-keyring.enable = true;
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

  programs = {
    # Enable Hyprland window manager (Wayland).
    hyprland.enable = true;
    dconf.enable = true;
  };

  security = {
    # Enable Gnome Keyring for KeeWeb etc.
    pam.services.login.enableGnomeKeyring = true;
    rtkit.enable = true;
    polkit.enable = true;
  };

  sound.enable = true;

  # Set system state version to the same as the input
  # to ensure that both nixos and home-manager share
  # the same system version (for example "23.05").
  system.stateVersion = inputs.stateVersion;
}
