let
  picomConfig = import ./configs/picom.nix;
  polybarConfig = import ./configs/polybar.nix;
  i3Config = import ./configs/i3.nix;
in {
  # picom = picomConfig pkgs;
  # polybar = polybarConfig pkgs;

  gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
