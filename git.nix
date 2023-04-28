pkgs:
{
	enable = true;
    userName = "Julius Koskela";
    userEmail = "me@juliuskoskela.dev";

    extraConfig = {
      commit.gpgsign = true;
    #   gpg.format = "ssh";
    #   gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
    #   user.signingkey = "~/.ssh/id_rsa.pub";
    };
}