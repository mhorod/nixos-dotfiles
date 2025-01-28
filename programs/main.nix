{ pkgs, libs, config, ... }:

{

	programs.firefox.enable = true;
	programs.hyprland.enable = true;

	environment.systemPackages = with pkgs; [
		alacritty
		btop
		feh
		git
		discord
		kitty
		neovim
		pavucontrol
		rofi
		vim
		wget
	];
}
