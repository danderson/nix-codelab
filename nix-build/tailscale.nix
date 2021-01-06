let
  pkgs = import <nixpkgs> {};
  lib = pkgs.lib;
  buildGoModule = pkgs.buildGoModule;
  fetchFromGitHub = pkgs.fetchFromGitHub;
  makeWrapper = pkgs.makeWrapper;
in
buildGoModule rec {
  pname = "tailscale";
  version = "1.2.10";
  tagHash = "4b3581abed6c2db79b61eb1b53e29645df12a833"; # from `git rev-parse v1.2.10`

  src = fetchFromGitHub {
    owner = "tailscale";
    repo = "tailscale";
    rev = "v${version}";
    sha256 = "09m4xhnjpnkic9jy5dwnmpl40r92xa8fcx4xhpadv6hjpx9k4xx5";
  };

  nativeBuildInputs = [ makeWrapper ];

  CGO_ENABLED = 0;

  vendorSha256 = "01g3jkgl3jrygd154gmjm3dq13nkppd993iym7assdz8mr3rq31s";

  doCheck = false;

  subPackages = [ "cmd/tailscale" "cmd/tailscaled" ];

  preBuild = ''
    export buildFlagsArray=(
      -tags="xversion"
      -ldflags="-X tailscale.com/version.Long=${version} -X tailscale.com/version.Short=${version} -X tailscale.com/version.GitCommit=${tagHash}"
    )
  '';

  postInstall = ''
    wrapProgram $out/bin/tailscaled --prefix PATH : ${
      lib.makeBinPath [ pkgs.iproute pkgs.iptables ]
    }
    sed -i -e "s#/usr/sbin#$out/bin#" -e "/^EnvironmentFile/d" ./cmd/tailscaled/tailscaled.service
    install -D -m0444 -t $out/lib/systemd/system ./cmd/tailscaled/tailscaled.service
  '';
}
