config:
  cp -r .config/* ~/.config/

install: config
  sudo cp *.nix /etc/nixos/

test: install
  sudo nixos-rebuild test

switch: install
  sudo nixos-rebuild switch
