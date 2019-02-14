with import <nixpkgs> {
  config = {
    allowUnfree = true;
  };

  overlays = [];

}; stdenv.mkDerivation {
  name = "games";
  src = ./.;

  buildInputs = [
    steam
    wine
  ];
}
