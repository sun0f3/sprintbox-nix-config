build:
	nixos-rebuild switch --flake ./#sb1
pull:
	git pull
up: pull build

clean:
	nix-store --gc

clean-journal:
	journalctl --vacuum-size=100M

journal-size:
	journalctl --disk-usage
