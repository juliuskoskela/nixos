let
  juliuskoskela = {
    user = import ./juliuskoskela;
    home = import ./juliuskoskela/home;
  };

  juliuskoskela-unikie = {
    user = import ./juliuskoskela-unikie;
    home = import ./juliuskoskela-unikie/home;
  };
in {
  inherit juliuskoskela juliuskoskela-unikie;
}
