# kven/programs/hyprland/default.nix
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
  #   programs = {
  #     zsh.loginExtra = ''
  #       if [ "$(tty)" = "/dev/tty1" ]; then
  #         exec Hyprland &> /dev/null
  #       fi
  #     '';
  #     zsh.profileExtra = ''
  #       if [ "$(tty)" = "/dev/tty1" ]; then
  #         exec Hyprland &> /dev/null
  #       fi
  #     '';
  #   };

  home.packages = with pkgs; [
    inputs.hyprwm-contrib.packages.${system}.grimblast
    swaybg
    swayidle
    wofi
    # TODO
    # inputs.hyprland.packages.${system}.xdg-desktop-portal-hyprland
  ];

  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or []) ++ ["-Dexperimental=true"];
      patches =
        (oa.patches or [])
        ++ [
          (pkgs.fetchpatch {
            name = "fix waybar hyprctl";
            url = "https://aur.archlinux.org/cgit/aur.git/plain/hyprctl.patch?h=waybar-hyprland-git";
            sha256 = "sha256-pY3+9Dhi61Jo2cPnBdmn3NUTSA8bAbtgsk2ooj4y7aQ=";
          })
        ];
    });
  };

  #   programs.waybar.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    extraConfig = import ./config.nix {
      inherit sessionVariables colorScheme;
    };
  };
}
