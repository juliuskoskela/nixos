{
  config,
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;
    theme = ./theme.rasi;
    plugins = with pkgs; [rofi-calc rofi-emoji];
    terminal = "${pkgs.alacritty}/bin/alacritty";
  };
}
