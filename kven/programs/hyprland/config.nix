# kven/programs/hyprland/config.nix
{
  sessionVariables,
  colorScheme,
}: let
  inherit (sessionVariables) TERMINAL BROWSER EDITOR;
in ''
  general {
    gaps_in=5
    gaps_out=10
    border_size=1.5
    col.active_border=0xff${colorScheme.colors.base0C}
    col.inactive_border=0xff${colorScheme.colors.base02}
    col.group_border_active=0xff${colorScheme.colors.base0B}
    col.group_border=0xff${colorScheme.colors.base04}
    cursor_inactive_timeout=4
  }

  decoration {
    active_opacity=0.94
    inactive_opacity=0.84
    fullscreen_opacity=1.0
    rounding=3
    blur=true
    blur_size=5
    blur_passes=3
    blur_new_optimizations=true
    blur_ignore_opacity=true
    drop_shadow=true
    shadow_range=12
    shadow_offset=3 3
    col.shadow=0x44000000
    col.shadow_inactive=0x66000000
  }

  animations {
    enabled=true

    bezier=easein,0.11, 0, 0.5, 0
    bezier=easeout,0.5, 1, 0.89, 1
    bezier=easeinout,0.45, 0, 0.55, 1

    animation=windowsIn,1,3,easeout,slide
    animation=windowsOut,1,3,easein,slide
    animation=windowsMove,1,3,easeout

    animation=fadeIn,1,3,easeout
    animation=fadeOut,1,3,easein
    animation=fadeSwitch,1,3,easeout
    animation=fadeShadow,1,3,easeout
    animation=fadeDim,1,3,easeout
    animation=border,1,3,easeout

    animation=workspaces,1,2,easeout,slide
  }

  dwindle {
    split_width_multiplier=1.35
  }

  misc {
    vfr=on
  }

  input {
    kb_layout=us,fi
    touchpad {
      disable_while_typing=false
    }
  }

  # Passthrough mode (e.g. for VNC)
  bind = SUPER,P,submap,passthrough
  submap=passthrough
  bind = SUPER,P,submap,reset
  submap=reset


  # Startup
  exec-once=waybar
  exec-once=swaybg -i ~/Pictures/wallpapers/dark-valley.jpg
  exec-once=mako
  exec-once=swayidle -w
  exec-once = wl-paste --type text --watch cliphist store
  exec-once = wl-paste --type image --watch cliphist store

  # Mouse binding
  bindm=SUPER,mouse:272,movewindow
  bindm=SUPER,mouse:273,resizewindow

  # Program bindings
  bind = SUPER,Return,exec,${TERMINAL} -e zsh
  bind = SUPER,b,exec,${BROWSER}

  bind = SUPER,x,exec,wofi -S drun -x 10 -y 10 -W 25% -H 60%
  bind = SUPER,d,exec,wofi -S run
  bind = ,Scroll_Lock,exec,pass-wofi # fn+k
  bind = ,XF86Calculator,exec,pass-wofi # fn+f12
  bind = SUPER, V, exec, cliphist list | wofi -dmenu | cliphist decode | wl-copy

  # Toggle waybar
  bind = ,XF86Tools,exec,pkill -USR1 waybar # profile button

  # Lock screen
  bind = ,XF86Launch5,exec,swaylock -S
  bind = ,XF86Launch4,exec,swaylock -S
  bind = SUPER,backspace,exec,swaylock -S

  # Screenshots
  bind = ,Print,exec,grimblast --notify copy output
  bind = SHIFT,Print,exec,grimblast --notify copy active
  bind = CONTROL,Print,exec,grimblast --notify copy screen
  bind = SUPER,Print,exec,grimblast --notify copy window
  bind = ALT,Print,exec,grimblast --notify copy area

  # Keyboard controls (brightness, media, sound, etc)
  bind = ,XF86MonBrightnessUp,exec,light -A 10
  bind = ,XF86MonBrightnessDown,exec,light -U 10

  bind = ,XF86AudioNext,exec,playerctl next
  bind = ,XF86AudioPrev,exec,playerctl previous
  bind = ,XF86AudioPlay,exec,playerctl play-pause
  bind = ,XF86AudioStop,exec,playerctl stop
  bind = ALT,XF86AudioNext,exec,playerctld shift
  bind = ALT,XF86AudioPrev,exec,playerctld unshift
  bind = ALT,XF86AudioPlay,exec,systemctl --user restart playerctld

  bind = ,XF86AudioRaiseVolume,exec,pactl set-sink-volume @DEFAULT_SINK@ +5%
  bind = ,XF86AudioLowerVolume,exec,pactl set-sink-volume @DEFAULT_SINK@ -5%
  bind = ,XF86AudioMute,exec,pactl set-sink-mute @DEFAULT_SINK@ toggle

  bind = SHIFT,XF86AudioMute,exec,pactl set-source-mute @DEFAULT_SOURCE@ toggle
  bind = ,XF86AudioMicMute,exec,pactl set-source-mute @DEFAULT_SOURCE@ toggle


  # Window manager controls
  bind = SUPER SHIFT,q,killactive
  bind = SUPER SHIFT,e,exit

  bind = SUPER,s,togglesplit
  bind = SUPER,f,fullscreen,1
  bind = SUPER SHIFT,f,fullscreen,0
  bind = SUPER SHIFT,space,togglefloating

  bind = SUPER,minus,splitratio,-0.25
  bind = SUPER SHIFT,minus,splitratio,-0.3333333

  bind = SUPER,equal,splitratio,0.25
  bind = SUPER SHIFT,equal,splitratio,0.3333333

  bind = SUPER,g,togglegroup
  bind = SUPER,apostrophe,changegroupactive,f
  bind = SUPER SHIFT,apostrophe,changegroupactive,b

  bind = SUPER,left,movefocus,l
  bind = SUPER,right,movefocus,r
  bind = SUPER,up,movefocus,u
  bind = SUPER,down,movefocus,d
  bind = SUPER,h,movefocus,l
  bind = SUPER,l,movefocus,r
  bind = SUPER,k,movefocus,u
  bind = SUPER,j,movefocus,d

  bind = SUPER SHIFT,left,swapwindow,l
  bind = SUPER SHIFT,right,swapwindow,r
  bind = SUPER SHIFT,up,swapwindow,u
  bind = SUPER SHIFT,down,swapwindow,d
  bind = SUPER SHIFT,h,swapwindow,l
  bind = SUPER SHIFT,l,swapwindow,r
  bind = SUPER SHIFT,k,swapwindow,u
  bind = SUPER SHIFT,j,swapwindow,d

  bind = SUPER CONTROL SHIFT, right, resizeactive, 30 0
  bind = SUPER CONTROL SHIFT, left, resizeactive, -30 0
  bind = SUPER CONTROL SHIFT, up, resizeactive, 0 -30
  bind = SUPER CONTROL SHIFT, down, resizeactive, 0 30

  bind= SUPER ALT SHIFT,left,movewindow,mon:l
  bind= SUPER ALT SHIFT,right,movewindow,mon:r
  bind= SUPER ALT SHIFT,up,movewindow,mon:u
  bind= SUPER ALT SHIFT,down,movewindow,mon:d
  bind= SUPER ALT SHIFT,h,movewindow,mon:l
  bind= SUPER ALT SHIFT,l,movewindow,mon:r
  bind= SUPER ALT SHIFT,k,movewindow,mon:u
  bind= SUPER ALT SHIFT,j,movewindow,mon:d

  bind = SUPER CONTROL,left,focusmonitor,l
  bind = SUPER CONTROL,right,focusmonitor,r
  bind = SUPER CONTROL,up,focusmonitor,u
  bind = SUPER CONTROL,down,focusmonitor,d
  bind = SUPER CONTROL,h,focusmonitor,l
  bind = SUPER CONTROL,l,focusmonitor,r
  bind = SUPER CONTROL,k,focusmonitor,u
  bind = SUPER CONTROL,j,focusmonitor,d

  bind = SUPER CONTROL,1,focusmonitor,DP-1
  bind = SUPER CONTROL,2,focusmonitor,DP-2
  bind = SUPER CONTROL,3,focusmonitor,DP-3

  bind=SUPER ALT,left,movecurrentworkspacetomonitor,l
  bind=SUPER ALT,right,movecurrentworkspacetomonitor,r
  bind=SUPER ALT,up,movecurrentworkspacetomonitor,u
  bind=SUPER ALT,down,movecurrentworkspacetomonitor,d
  bind=SUPER ALT,h,movecurrentworkspacetomonitor,l
  bind=SUPER ALT,l,movecurrentworkspacetomonitor,r
  bind=SUPER ALT,k,movecurrentworkspacetomonitor,u
  bind=SUPER ALT,j,movecurrentworkspacetomonitor,d

  bind = SUPER,u,togglespecialworkspace
  bind = SUPER SHIFT,u,movetoworkspace,special

  bind = SUPER,1,workspace,01
  bind = SUPER,2,workspace,02
  bind = SUPER,3,workspace,03
  bind = SUPER,4,workspace,04
  bind = SUPER,5,workspace,05
  bind = SUPER,6,workspace,06
  bind = SUPER,7,workspace,07
  bind = SUPER,8,workspace,08
  bind = SUPER,9,workspace,09
  bind = SUPER,0,workspace,10
  bind = SUPER,f1,workspace,11
  bind = SUPER,f2,workspace,12
  bind = SUPER,f3,workspace,13
  bind = SUPER,f4,workspace,14
  bind = SUPER,f5,workspace,15
  bind = SUPER,f6,workspace,16
  bind = SUPER,f7,workspace,17
  bind = SUPER,f8,workspace,18
  bind = SUPER,f9,workspace,19
  bind = SUPER,f10,workspace,20
  bind = SUPER,f11,workspace,21
  bind = SUPER,f12,workspace,22

  bind = SUPER SHIFT,1,movetoworkspacesilent,01
  bind = SUPER SHIFT,2,movetoworkspacesilent,02
  bind = SUPER SHIFT,3,movetoworkspacesilent,03
  bind = SUPER SHIFT,4,movetoworkspacesilent,04
  bind = SUPER SHIFT,5,movetoworkspacesilent,05
  bind = SUPER SHIFT,6,movetoworkspacesilent,06
  bind = SUPER SHIFT,7,movetoworkspacesilent,07
  bind = SUPER SHIFT,8,movetoworkspacesilent,08
  bind = SUPER SHIFT,9,movetoworkspacesilent,09
  bind = SUPER SHIFT,0,movetoworkspacesilent,10
  bind = SUPER SHIFT,f1,movetoworkspacesilent,11
  bind = SUPER SHIFT,f2,movetoworkspacesilent,12
  bind = SUPER SHIFT,f3,movetoworkspacesilent,13
  bind = SUPER SHIFT,f4,movetoworkspacesilent,14
  bind = SUPER SHIFT,f5,movetoworkspacesilent,15
  bind = SUPER SHIFT,f6,movetoworkspacesilent,16
  bind = SUPER SHIFT,f7,movetoworkspacesilent,17
  bind = SUPER SHIFT,f8,movetoworkspacesilent,18
  bind = SUPER SHIFT,f9,movetoworkspacesilent,19
  bind = SUPER SHIFT,f10,movetoworkspacesilent,20
  bind = SUPER SHIFT,f11,movetoworkspacesilent,21
  bind = SUPER SHIFT,f12,movetoworkspacesilent,22

  blurls=waybar
''
