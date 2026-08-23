HOST := noir
FLAKE := $(CURDIR)

.PHONY: switch build fmt update check

switch:
	sudo nixos-rebuild switch --flake $(FLAKE)#$(HOST)

build:
	nixos-rebuild build --flake $(FLAKE)#$(HOST)

fmt:
	nix run .#formatter.x86_64-linux -- .

update:
	nix flake update
	nix run .#formatter.x86_64-linux -- .

check:
	nix flake check
