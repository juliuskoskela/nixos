{pkgs, ...}: let
  hyprcwd = pkgs.writeShellScriptBin "hyprcwd" ./hyprcwd.sh;
in {
  environment.systemPackages = [
    hyprcwd
  ];
}
