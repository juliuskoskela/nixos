pkgs:
{
	enable = true;

	script = "pkill polybar; sleep 1; polybar bottom &";

	config = {
		"bar/bottom" = {
			monitor = "\${env:MONITOR:}";
			width = "100%";
			height = 60;
			radius = 0;
			fixed-center = true;
			bottom = true;

			background = "#88000000";
			foreground = "#aaaaaa";

			line-size = 3;
			# line-color =

			border-size = 0;
			# border-color =

			padding-left = 0;
			padding-right = 2;
			module-margin-left = 1;
			module-margin-right = 2;

			font-0 = "JetBrains Mono Semibold:size=16;1";
			font-1 = "Font Awesome 5 Free:style=Solid:size=16;1";
			font-2 = "Font Awesome 5 Brands:size=16;1";

			modules-left = "i3";
			modules-center = "spotify";
			modules-right = "date wlan eth powermenu";

			# tray-position =
			# tray-padding =
			wm-restack = "i3";
			override-redirect = true;

			cursor-click = "pointer";
			cursor-scroll = "ns-resize";
		};

		"module/i3" = {
			type = "internal/i3";
			format = "<label-state> <label-mode>";
			index-sort = true;
			wrapping-scroll = false;

			pin-workspaces = true;

			label-mode-padding = 2;
			label-mode-foreground = "#657b83";
			label-mode-background = "#272827";

			label-focused = "%name%";
			label-focused-foreground = "#FF8F40";
			label-focused-padding = 2;

			label-unfocused = "%name%";
			label-unfocused-foreground = "#666666";
			label-unfocused-padding = 2;

			label-visible = "%name%";
			label-visible-foreground = "#39BAE6";
			label-visible-padding = 2;

			label-urgent = "%name%";
			label-urgent-background = "#FF3333";
			label-urgent-padding = 2;
		};

		"module/wlan" = {
			type = "internal/network";
			interface = "net1";
			interval = "3.0";

			format-connected = "<ramp-signal> <label-connected>";
			format-connected-foreground = "#272827";
			format-connected-background = "#7E807E";
			format-connected-padding = 2;
			label-connected = "%essid%";

			# format-disconnected =

			ramp-signal-0 = "";
			ramp-signal-1 = "";
			ramp-signal-2 = "";
			ramp-signal-3 = "";
			ramp-signal-4 = "";
			ramp-signal-foreground = "#272827";
		};

		"module/eth" = {
			type = "internal/network";
			interface = "enp37s0";
			interval = "3.0";

			format-connected-padding = 2;
			format-connected-foreground = "#91B362";
			format-connected-prefix-foreground = "#91B362";
			label-connected = "";

			# format-disconnected =
		};

		"module/date" = {
			type = "internal/date";
			interval = 5;

			# date =
			date-alt = " %Y-%m-%d";

			time = "%H:%M";
			time-alt = "%H:%M:%S";

			format-prefix = "";
			format-foreground = "#aaaaaa";
			format-padding = 2;

			label = "%date% %time%";
		};

		"module/powermenu" = {
			type = "custom/menu";

			expand-right = true;

			format-spacing = 1;

			label-open = "";
			label-open-foreground = "#FF8F40";
			label-close = " cancel";
			label-close-foreground = "#FF3333";
			label-separator = "|";
			label-separator-foreground = "#FF3333";

			menu-0-0 = "reboot";
			menu-0-0-exec = "menu-open-1";
			menu-0-1 = "power off";
			menu-0-1-exec = "menu-open-2";
			menu-0-2 = "log off";
			menu-0-2-exec = "menu-open-3";

			menu-1-0 = "cancel";
			menu-1-0-exec = "menu-open-0";
			menu-1-1 = "reboot";
			menu-1-1-exec = "reboot";

			menu-2-0 = "power off";
			menu-2-0-exec = "poweroff";
			menu-2-1 = "cancel";
			menu-2-1-exec = "menu-open-0";

			menu-3-0 = "log off";
			menu-3-0-exec = "i3 exit logout";
			menu-3-1 = "cancel";
			menu-3-1-exec = "menu-open-0";
		};
	};

	settings = {
		screenchange.reload = true;

		"global/wm" = {
			margin-top = 0;
			margin-bottom = 0;
		};

		"module/spotify" = {
			type = "custom/script";
			interval = 1;
			format-prefix = " ";
			format = "<label>";
			format-foreground = "#888888";
			exec = "python /home/julius/Julius/Scripts/spotify_status.py -f '{artist}: {song}'";
		};

		# click-left = "playerctl --player=spotify play-pause";
		# click-right = "playerctl --player=spotify next";
		# click-middle = "playerctl --player=spotify previous";
	};
}