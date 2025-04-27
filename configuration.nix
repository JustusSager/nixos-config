# Edit this configuration file to define what should be installed on your system
# Help is available in the configuration.nix(5) man page and in the NixOS manual (by runnung 'nixos-help')
{ config, pkgs, ... }:

{
  imports =
    [ # include the results of the hardware scan.
      ./hardware-configuration.nix
    ];
  # Bootloader
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
  };
  networking.hostName = "nixos"; # Define Hostname
  # networking.wireless.enable = true; # Enable wireless support via wpa_supplicant

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:passwd@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internam.domain";

  # enable networking
  networking.networkmanager.enable = true;

  # set time zone
  time.timeZone = "Europe/Berlin";

  # select internationalisation properties
  i18n.defaultLocale = "de_DE.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MESUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LCTIME = "de_DE.UTF-8";
  };

  # enable/disable the X11 windowing system
  services.xserver.enable = false;

  # configure console keymap
  console.keyMap = "de";

  # enable CUPS to print documents
  services.printing.enable = true;

  # enable sound with pipewire
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;

    # use the example sission manager (no others are packaged yet so this is enabled by default)
    # no need to redefine it in your config for now
    #media-session.enable = true;
  };

  # enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Dont forget to set a passwd with 'passwd'
  users.users.findus = {
    isNormalUser = true;
    description = "Findus";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    packages = with pkgs; [
      # install user specific packages
      # thunderbird
    ];
  };

  # TTY Auto Login
  services.getty.autologinUser = "findus";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Install Software with Home Manager ------------------------------
  # Install firefox
  programs.firefox.enable = true;

  # List packages installed in system profile. To search run 'nix search <package name>'
  environment.systemPackages = with pkgs; [
    # Basic Wayland must have stuff
    foot # simple terminal
    wofi # search bar / application launcher
    dolphin # file manager
    vim # cli text editor
    nano # cli text editor
    wget # cli file downloader
    waybar # task bar
    wl-clipboard # clipboard functionalities
    firefox # web browser
    git # cli git
    # personal stuff
    neovim # better terminal text editor
    nautilus # better file browser
    # kitty # terminal evtl benötigt für neovim
    # Die Jetbrains IDE Palette und was dafür nötig ist
    jetbrains.idea-ultimate         # IntelliJ 
    jetbrains.clion                 # CLion
    jetbrains.pycharm-professional  # PyCharm
    jetbrains.webstorm              # WebStorm
    gcc                             # C/C++ compiler
    python313                       # python3 interpreter
    conda                           # python package manager
    # Office
    obsidian # notes
    thunderbird # email client
    sublime # gui text editor
    
  ];

  # hyprland setup
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # Some programs need SUID wrappers, can be configured further or started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable
  # services.openssh.enable = true;

  # Firewall Settings
  networking.firewall.enable = true;
  # networking.firewall.allowedTCPPorts = [...];
  # networking.firewall.allowedUDPPorts = [...];

  # NixOS release from which the default settings for stateful data were taken.
  # Do not touch without reading the docs
  system.stateVersion = "24.11";
}
