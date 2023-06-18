# kven/programs/wayland/default.nix
{
  services.xserver = import ./config.nix;
}
