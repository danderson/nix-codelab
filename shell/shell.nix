{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    nodejs-12_x
    sass
    go
    git
    bash
  ];
}
