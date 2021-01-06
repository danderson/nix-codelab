let pkgs = import <nixpkgs> {}; in
pkgs.stdenv.mkDerivation {
  pname = "hello";
  version = "1.2.3";
  src = ./src;
}
