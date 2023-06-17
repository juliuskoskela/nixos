{
  config,
  pkgs,
  ...
}: {
  enable = true;
  # videosDrivers = ["nvidia"];
  displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  layout = "us,fi";
  # xkbVariant = "";
}
