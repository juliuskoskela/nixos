{pkgs, ...}: {
  # inherit pkgs;
  name = "hypr";
  system = "x86_64-linux";
  timeZone = "Europe/Helsinki";
  stateVersion = "23.05";

  localeSettings = {
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

  hardwareConfig = import ./hardware-configuration.nix;

  bootConfig = {
    timeout = 30;
    efi = {
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      theme = pkgs.nixos-grub2-theme;
      efiSupport = true;
      efiInstallAsRemovable = true; # Otherwise /boot/EFI/BOOT/BOOTX64.EFI isn't generated
      devices = ["nodev"];
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

  hostConfig = {
    hardware = {
      bluetooth.enable = true;
      opengl.enable = true;
      opengl.driSupport32Bit = true; # Required for Steam
      pulseaudio.enable = false;
    };

    services = {
      openssh.enable = true;
      printing.enable = true;
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
    };

    nixpkgs.config = {
      # TODO! Required by nixvim and Copilot, remove if Copilot is udpated
      # to use the new version of nodejs.
      permittedInsecurePackages = [
        "nodejs-16.20.0"
      ];
    };
  };

  hostPackages = with pkgs; [
    python3
    nodejs
    openssl
  ];
}
