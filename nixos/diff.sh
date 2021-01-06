#!/usr/bin/env nix-shell
#!nix-shell -i bash -p nix-diff

set -euo pipefail

export PAGER=less
echo "Computing new configuration..."
newd=$(cd /etc/nixos && nix-instantiate '<nixpkgs/nixos>' -A system)
echo "Fetching current configuration..."
curd=$(nix-store -qd /run/current-system)
nix-diff --color=always $curd $newd
