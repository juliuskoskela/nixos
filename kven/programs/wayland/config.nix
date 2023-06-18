# kven/programs/wayland/config.nix
{
  enable = true;
  desktopManager.
  displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  layout = "us,fi";
}
