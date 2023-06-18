# kven/programs/default.nix
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  hyprland = import ./hyprland;
  alacritty = import ./alacritty;
  gnome = import ./gnome;
  wayland = import ./wayland;
  zsh = import ./zsh;
in {
  inherit hyprland alacritty gnome wayland zsh;
}
