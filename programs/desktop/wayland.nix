{
  config,
  pkgs,
  ...
}: {
  enable = true;
  # videosDrivers = ["nvidia"];
  desktopManager.
  displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  layout = "us,fi";
  # xkbVariant = "";
}
