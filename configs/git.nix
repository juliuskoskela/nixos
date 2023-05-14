pkgs:
{
	enable = true;
    userName = "Julius Koskela";
    userEmail = "me@juliuskoskela.dev";

    extraConfig = {
      commit.gpgsign = true;
      user.signingkey = "8539EF4CE6367B81";
    };
}