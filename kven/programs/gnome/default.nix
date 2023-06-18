# kven/programs/gnome/default.nix
pkgs: {
  services.xserver = {
    enable = true;
    config = import ./config.nix {inherit pkgs;};
  };
}
