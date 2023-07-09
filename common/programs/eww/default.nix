{
  inputs,
  pkgs,
  sessionVariables,
  colorScheme,
  ...
}: {
  programs.eww = {
    enable = true;
    package = pkgs.eww-wayland;
    configDir = ./config;
  };
}
