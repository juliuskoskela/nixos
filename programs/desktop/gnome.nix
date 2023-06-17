{
  config,
  pkgs,
  ...
}: {
  enable = true;
  displayManager.gdm.enable = true;
  desktopManager.gnome.enable = true;
  windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
  };
  layout = "us,fi";
  xkbVariant = "";
}
