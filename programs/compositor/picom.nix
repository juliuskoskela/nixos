pkgs:
{
  enable = true;

  # Basic
  inactiveOpacity = 0.9;
  backend = "glx";
  vSync = true;

  # Opacity
  opacityRules = [
    "100:class_g = 'Alacritty'"
  ];

  # Corners
  settings = {
    cornerRadius = 10;
    detectRoundedCorners = true;
    roundedCornersExclude = [
      "_NET_WM_WINDOW_TYPE@[0]:a = '_NET_WM_WINDOW_TYPE_DOCK'"
    ];
  };

  # Fade
  fade = true;
  fadeDelta = 10;
  fadeSteps = [ 0.028 0.03 ];
}
