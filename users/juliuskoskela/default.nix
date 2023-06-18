# users/juliuskoskela/default.nix
{
  inputs,
  pkgs,
  ...
}: {
  users.users.juliuskoskela = {
    isNormalUser = true;
    description = "Julius Koskela";
    extraGroups = ["networkmanager" "wheel"];
  };

  home-manager.users.juliuskoskela = import ./home {inherit inputs pkgs;};
}
