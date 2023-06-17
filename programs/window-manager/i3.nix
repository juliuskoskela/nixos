{
  pkgs,
  lib,
  ...
}: let
  mod = "Mod4";
in {
  enable = true;
  package = pkgs.i3-gaps;

  config = {
    modifier = "Mod4";
    # bars = [ ];

    window.border = 0;

    gaps = {
      inner = 8;
      outer = 0;
      bottom = 60;
    };

    # set = {
    # 	"$ws1" = 1;
    # 	"$ws2" = 2;
    # 	"$ws3" = 3;
    # 	"$ws4" = 4;
    # 	"$ws5" = 5;
    # 	"$ws6" = 6;
    # 	"$ws7" = 7;
    # 	"$ws8" = 8;
    # 	"$ws9" = 9;

    # 	"$ws10" = "Web";
    # 	"$ws11" = "Chat";
    # 	"$ws12" = "Music";
    # };

    # fonts = [ "JetBrains Mono Nerd Fonts" ];

    keybindings = lib.mkOptionDefault {
      # Special keys
      "XF86AudioMute" = "exec amixer set Master toggle";
      "XF86AudioLowerVolume" = "exec amixer set Master 4%-";
      "XF86AudioRaiseVolume" = "exec amixer set Master 4%+";
      "XF86MonBrightnessDown" = "exec brightnessctl set 4%-";
      "XF86MonBrightnessUp" = "exec brightnessctl set 4%+";

      # Launch and suspend
      "${mod}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
      "${mod}+d" = "exec ${pkgs.rofi}/bin/rofi -modi drun -show drun";
      "${mod}+Shift+d" = "exec ${pkgs.rofi}/bin/rofi -show window";
      "${mod}+Shift+x" = "exec systemctl suspend";

      # Focus
      "${mod}+j" = "focus left";
      "${mod}+k" = "focus down";
      "${mod}+l" = "focus up";
      "${mod}+semicolon" = "focus right";

      "${mod}+Left" = "focus left";
      "${mod}+Down" = "focus down";
      "${mod}+Up" = "focus up";
      "${mod}+Right" = "focus right";

      # Move focused window
      "${mod}+Shift+j" = "move left";
      "${mod}+Shift+k" = "move down";
      "${mod}+Shift+l" = "move up";
      "${mod}+Shift+semicolon" = "move right";

      "${mod}+Shift+Left" = "move left";
      "${mod}+Shift+Down" = "move down";
      "${mod}+Shift+Up" = "move up";
      "${mod}+Shift+Right" = "move right";
    };

    startup = [
      {
        command = "exec i3-msg workspace 1";
        always = true;
        notification = false;
      }
      # {
      # 	command = "systemctl --user restart polybar.service";
      # 	always = true;
      # 	notification = false;
      # }
      {
        command = "${pkgs.feh}/bin/feh --bg-scale ~/background.jpg";
        always = true;
        notification = false;
      }
    ];
  };
}
