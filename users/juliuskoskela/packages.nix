pkgs:
with pkgs; [
  # Browser
  firefox

  # Editors
  vscode
  lapce

  # Productivity
  obsidian

  # !TODO: Figure configuration
  zathura

  # Communication
  zulip
  slack
  discord
  whatsapp-for-linux
  thunderbird
  protonmail-bridge
  neomutt

  # Langauges
  jdk19
  perl

  # Tools
  nextcloud-client
  gh
  curl
  wget
  nixpkgs-fmt
  hardinfo
  appimage-run
  ripgrep
  fd

  # Entertainment
  steam
  spotify

  # Security
  gnupg
  keeweb

  # Development
  gcc
  gnumake

  # Audio
  bitwig-studio
  audacity

  # Photo
  gimp
  inkscape
  darktable

  # Finance
  hledger

  # Fonts
  (nerdfonts.override {
    fonts = [
      "FiraCode"
      "DroidSansMono"
      "JetBrainsMono"
    ];
  })

  # Texlive
  (texlive.combine {inherit (texlive) scheme-medium xifthen ifmtarg framed paralist titlesec;})

  # Gnome Extensions
  gnomeExtensions.user-themes
  gnomeExtensions.tray-icons-reloaded
  gnomeExtensions.vitals
  gnomeExtensions.dash-to-panel
  gnomeExtensions.sound-output-device-chooser
  gnomeExtensions.space-bar
]
