
install:
	sudo cp -r programs /etc/nixos/programs
	sudo cp *.nix /etc/nixos/

test: install
	sudo nixos-rebuild test

switch: install
	sudo nixos-rebuild switch
