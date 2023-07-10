pkgs:
with pkgs; [
  # Browser
  firefox

  # Editors
  vscode
  lapce

  # Productivity
  obsidian
  blender

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
  rustup

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
  blueman
  minicom
  usbutils
  nmap
  alsa-lib
  alsa-tools
  alsa-utils

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
]
