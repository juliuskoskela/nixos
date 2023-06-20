# kven/programs/hyprland/default.nix
{
  inputs,
  pkgs,
  system,
  sessionVariables,
  colorScheme,
  ...
}: {
  programs.waybar = {
    enable = true;
    package = inputs.hyprland.packages.${system}.waybar-hyprland;

    style = ''
        ${builtins.readFile "${pkgs.waybar}/etc/xdg/waybar/style.css"}
        * {
            border: none;
            border-radius: 0;
            font-family: JetBrains Mono Nerd Font;
            font-size: 11pt;
            min-height: 0;
        }
        window#waybar {
            opacity: 0.9;
            background: #${colorScheme.colors.base00};
            color: #${colorScheme.colors.base05};
      border-bottom: 0px;
        }
        #workspaces button {
            padding: 0 10px;
            background: #${colorScheme.colors.base00};
            color: #${colorScheme.colors.base05};
        }
        #workspaces button:hover {
            box-shadow: inherit;
            text-shadow: inherit;
            background-image: linear-gradient(0deg, #${colorScheme.colors.base02}, #${colorScheme.colors.base00});
        }
        #workspaces button.active {
            background-image: linear-gradient(0deg, #${colorScheme.colors.base0D}, #${colorScheme.colors.base02});
        }
        #taskbar button.active {
            background-image: linear-gradient(0deg, #${colorScheme.colors.base02}, #${colorScheme.colors.base00});
        }
        #clock {
            padding: 0 4px;
            background: #${colorScheme.colors.base00};
        }

    '';

    settings = [
      {
        layer = "top";
        position = "top";
        height = 32;
        spacing = 4;

        modules-left = [
          "wlr/workspaces"
          "wlr/taskbar"
          "network"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "tray"
          "custom/weather"
          "clock"
          "battery"
          "hyprland/language"
        ];

        "network" = {
          format-wifi = "{ifname}->{essid}({signalStrength}%)->{ipaddr}";
        };
        "wlr/taskbar" = {
          on-click = "activate";
          on-click-middle = "close";
          ignore-list = [
            "foot"
          ];
        };
        "wlr/workspaces" = {
          on-click = "activate";
          on-scroll-up = "hyprctl dispatch workspace e-1";
          on-scroll-down = "hyprctl dispatch workspace e+1";
        };
        "hyprland/window" = {
          max-length = 128;
        };
        "clock" = {
          format = "{:%c}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
        "tray" = {
          spacing = 4;
        };
        "custom/weather" = {
          exec = ''
            #!/usr/bin/sh
            req=$(curl -s wttr.in/?format="%t|%l+(%c%f)+%h,+%C")
            bar=$(echo $req | awk -F "|" '{print $1}')
            tooltip=$(echo $req | awk -F "|" '{print $2}')
            echo "{\"text\":\"$bar\", \"tooltip\":\"$tooltip\"}"
          '';
          return-type = "json";
          format = "{}";
          tooltip = true;
          interval = 900;
        };
        "hyprland/language" = {
          format-fi = "[fi]";
          format-en = "[us]";

          # !TODO Figure out on click switch, this command doesn't work but
          # hyprctl keyword input:kb_layout fi does.
          on-click = "hyprctl switchxkblayout next";
        };
      }
    ];
  };
}
