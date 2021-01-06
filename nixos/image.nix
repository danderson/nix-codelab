{ config, pkgs, ... }: {
  imports = [ ./configuration.nix ];
  virtualisation.digitalOceanImage = {
    configFile = ./configuration.nix;
  };
}
