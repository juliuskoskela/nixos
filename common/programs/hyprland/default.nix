# common/programs/hyprland/default.nix
{
  inputs,
  pkgs,
  sessionVariables,
  colorScheme,
  ...
}: {
  imports = [
    inputs.hyprland.homeManagerModules.default
  ];

  home.packages = with pkgs; [
    inputs.hyprwm-contrib.packages.${system}.grimblast
    swaybg
    swayidle
    wofi
    # TODO
    # inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    extraConfig = import ./config.nix {
      inherit sessionVariables colorScheme;
    };
  };
}
