#!/usr/bin/env bash

systemNode=$(readlink -f `which node`)

for path in ~/.vscode-server/bin/*/node; do
	ln -sf "$systemNode" "$path"
done

echo "Fixup done, try connecting your vscode remote again"
