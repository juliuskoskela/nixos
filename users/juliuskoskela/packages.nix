pkgs:
with pkgs; [
  # System

  yazi # Terminal file explorer
  ueberzugpp # Display images in terminal
  gitoxide # Alternative Git client `gix`
  firefox # Default browser

  # Programming

  tea # Gitea CLI
  vscode # Visual Studio Code
  lapce # Code editor build with Rust
  # github-desktop # Github desktop client
  # gitkraken # Git client
  # gitnuro # Git client

  # Productivity

  obsidian # Note taking
  blender # 3D modelling
  dnglab # Convert RAW images to DNG
  zathura # PDF viewer

  # Communication

  irssi
  mattermost-desktop
  zulip # Open source chatroom client
  slack # Proprietary chatroom client
  discord # Proprietary chatroom client
  whatsapp-for-linux # Whatsapp client
  thunderbird # Email client
  protonmail-bridge # Protonmail encryption bridge
  neomutt # Terminal email client

  # Languages

  jdk19 # Java development kit
  perl # Perl
  rustup # Rust

  # Tools

  pandoc # Document converter
  unzip # Unzip utility
  spotdl # Spotify downloader
  drone-cli # Drone CI
  nextcloud-client # Nextcloud client
  gh # Github CLI
  curl # URL transfer utility
  wget # URL transfer utility
  nixpkgs-fmt # Nix formatter
  hardinfo # System information
  appimage-run # AppImage runner
  ripgrep # Search utility
  fd # Search utility
  blueman # Bluetooth manager
  minicom # Terminal serial port manager
  usbutils # USB utilities
  nmap # Network scanner
  alsa-lib # Audio library
  alsa-tools # Audio tools
  alsa-utils # Audio utilities
  dtc # Device tree compiler
  putty # SSH client
  nftables # Firewall
  dnsmasq # DNS server
  deploy-rs # Deployment tool
  jq # JSON processor
  bison # Parser generator
  flex # Lexical analyser
  quilt # Patch manager
  nushell # Shell
  htop # Process viewer
  btop # Process viewer
  neofetch # System information
  inetutils # Telnet client

  # Testing

  gpsd # GPS daemon

  # Entertainment

  steam # Steam gaming platform
  spotify # Music streaming

  # Security

  pcscliteWithPolkit
  yubikey-manager # Yubikey manager
  yubikey-personalization
  yubikey-personalization-gui
  gnupg # GPG encryption
  keeweb # Password manager
  sops # Encrypted file editor

  # Development

  gcc # GNU compiler collection
  gnumake # GNU make

  # Audio

  bitwig-studio # Digital audio workstation
  audacity # Audio editor

  # Photo

  gimp # Image editor
  inkscape # Vector graphics editor
  darktable # RAW image editor

  # Finance

  hledger # Ledger accounting

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
