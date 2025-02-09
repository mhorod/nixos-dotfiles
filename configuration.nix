# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./locale.nix
    ./nixvim.nix
  ];

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    useOSProber = true;
    device = "nodev";
  };
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.bluetooth.enable = true;

  networking.networkmanager.enable = true; 


  nixpkgs.config.allowUnfree = true;
  # programs
  programs.firefox.enable = true;
  programs.hyprland.enable = true;
  programs.java.enable = true;
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    killall
    ddcutil
    alacritty
    btop
    eza
    feh
    git
    just
    graphviz
    fastfetch
    discord
    kitty
    brightnessctl
    pavucontrol
    rofi
    waybar
    wget

    # hyprland
    hyprpaper
    hyprshot
    hyprlock
    hyprcursor
    pywal
    wpaperd


    # editors
    vim
    vscode
    jetbrains.idea-ultimate
    wl-clipboard-x11

    # programming languages
    jq
    rustup
    tree-sitter
    nodejs_23
    deno
    jdk17
    python314
    gcc
    nasm
    stack
    kotlin
  ];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # console = {
  #  font = "Lat2-Terminus16";
  #  keyMap = "pl";
  #  useXkbConfig = true; # use xkb.options in tty.
  #};
  console = {
    earlySetup = true;
    useXkbConfig = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-extra
    noto-fonts-emoji
    liberation_ttf
    fira-code
    powerline-fonts
    powerline-symbols
    font-awesome
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    nerdfonts
  ];

  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    fontconfig = {
      enable = true;
      useEmbeddedBitmaps = true;
      defaultFonts = {
        serif = ["Noto Serif"];
        sansSerif = ["Noto Sans"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  users.users.mhorod = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = ["wheel"];
    packages = with pkgs; [
      tree
    ];
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  environment.variables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    JAVA_17_HOME = "${pkgs.jdk17}/lib/openjdk";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [3000 9993];
  networking.firewall.allowedUDPPorts = [9993];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # yada yada, do not modify
  system.stateVersion = "24.11";
}
