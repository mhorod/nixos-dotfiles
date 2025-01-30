
install:
  sudo cp *.nix /etc/nixos/
  cp -r .config ~/.config

test: install
  sudo nixos-rebuild test

switch: install
  sudo nixos-rebuild switch
