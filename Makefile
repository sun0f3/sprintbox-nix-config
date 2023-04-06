build:
	nixos-rebuild switch --flake ./#sb1
pull:
	git pull
up: pull build

clean:
	nix-store --gc

