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

    style = ''
      ${builtins.readFile "${pkgs.waybar}/etc/xdg/waybar/style.css"}
      @define-color background-darker rgba(30, 31, 41, 230);
      @define-color background #${colorScheme.colors.base00};
      @define-color selection #${colorScheme.colors.base02};
      @define-color foreground #${colorScheme.colors.base05};
      @define-color comment #${colorScheme.colors.base03};
      @define-color cyan #${colorScheme.colors.base08};
      @define-color green #${colorScheme.colors.base09};
      @define-color orange #${colorScheme.colors.base0A};
      @define-color pink #${colorScheme.colors.base0B};
      @define-color purple #${colorScheme.colors.base0D};
      @define-color red #${colorScheme.colors.base0D};
      @define-color yellow #${colorScheme.colors.base0E};
      * {
          border: none;
          border-radius: 0;
          font-family: JetBrains Mono Nerd Font;
          font-size: 11pt;
          min-height: 0;
      }
      window#waybar {
          opacity: 0.9;
          background: @background-darker;
          color: @foreground;
          border-bottom: 2px solid @background;
      }
      #workspaces button {
          padding: 0 10px;
          background: @background;
          color: @foreground;
      }
      #workspaces button:hover {
          box-shadow: inherit;
          text-shadow: inherit;
          background-image: linear-gradient(0deg, @selection, @background-darker);
      }
      #workspaces button.active {
          background-image: linear-gradient(0deg, @purple, @selection);
      }
      #taskbar button.active {
          background-image: linear-gradient(0deg, @selection, @background-darker);
      }
      #clock {
          padding: 0 4px;
          background: @background;
      }

    '';

    settings = [
      {
        layer = "top";
        position = "top";
        height = 24;
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
        #   on-click = "hyprctl switchxkblayout at-translated-set-2-keyboard next";
        };
      }
    ];
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    extraConfig = import ./config.nix {
      inherit sessionVariables colorScheme;
    };
  };
}
