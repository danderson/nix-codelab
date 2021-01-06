#!/usr/bin/env nix-shell
#!nix-shell --pure -i bash -p git python go

git --version
python --version
go version
echo "I can run $(compgen -c | wc -l) commands"
