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
  
  # setup the window manager
  services.xserver = {
    enable = false;
    
    #desktopManager = {
    #  xterm.enable = false;
    #};
    #
    #displayManager = {
    #  defaultSession = "none+i3";
    #};
    #
    #windowManager.i3 = {
    #  enable = true;
    #  extraPackages = with pkgs; [
    #    dmenu     # application launcher
    #    i3status  # default i3 status bar
    #    i3lock    # default i3 lock screen
    #    #i3blocks  # 
    #  ];
    #};
  };

  # hyprland setup
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  
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
    # If you want to uuse JACK applications, uncomment this
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

  # Install firefox
  programs.firefox = {
    enable = true;
    languagePacks = [ "de" "en-US" ];
    policies = {
      # https://mozilla.github.io/policy-templates/
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisableFirefoxAccounts = true;
      # Lesezeichenleiste anzeigen? ["always" "newtab" "never"]     
      DisplayBookmarksToolbar = "newtab";
      # Menüleiste anzeigen? ["always" "default-on" "default-off" "never"]
      DisplayMenuBar = "default-off";
      # Suchleiste und Adressleiste trennen? ["unified" "seperate"]
      SearchBar = "unified";
      # Anbieten Passwörter zu speichern?
      OfferToSaveLogins = false;
      # Passwortmanager deaktivieren?
      PasswordManagerEnabled = false;
    };
  };
  
  # VirtualBox Setup
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  users.extraGroups.vboxusers.members = [ "findus" ];

  # Docker Setup
  virtualisation.docker.enable = true;
  # virtualisation.podman.enable = true;


  # List packages installed in system profile. To search run 'nix search <package name>'
  environment.systemPackages = with pkgs; [
    # ------------- Basic Wayland must have stuff ---------------
    wofi  # search bar / application launcher
    waybar # task bar
    wl-clipboard # clipboard functionalities
    wget # cli file downloader
    mako # notification daemon
    
    # Terminal
    foot   # simple terminal
    #kitty # terminal evtl benötigt für neovim
    
    # file manager
    dolphin                 # file manager
    #kdePackages.qtsvg     # dolphin needs some symbols
    #libsForQt5.kio-extras # mooore dolpin symbols
    file-roller             # Zip Archive
    
    # Text Editors
    vim      # cli text editor
    nano     # cli text editor
    sublime  # gui text editor

    # Webbrowser
    firefox # web browser

    # ----------------- Softwareentwicklung ---------------------
    #neovim # better terminal text editor
    git # cli git
    gitg # git gui
    docker # Docker Container
    docker-compose # Docker compose Erweiterung für docker
    #podman # managing pods, containers and container images
    #podman-desktop # GUI für Podman Container
    
    # Java, Kotlin
    jetbrains.idea-ultimate  # IntelliJ 
    
    # C, C++
    jetbrains.clion  # CLion
    cmake            # - CMake
    ninja            # - build tool
    gcc              # - C / C++ Compiler
    sfml             # - Brauch ich evtl nicht
    #xorg.libX11      # - Nötig für die CMake SFML Entwicklung
    #xorg.libXi
    #xorg.libXext
    #xorg.xorgproto
    #xorg.libXcursor
    #xorg.libXinerama
    
    # Python
    jetbrains.pycharm-professional  # PyCharm
    python313                       # - python3 interpreter
    conda                           # - python package manager
    
    # Web
    jetbrains.webstorm  # WebStorm
    
    # ---------------------- Office -----------------------------
    obsidian # notes
    thunderbird # email client
    discord-ptb # Discord halt
    #qgis-ltr # QGIS läuft leider nicht mit Hyprland wird ausgelagert in eine VM
  ];

  # Schriftarten
  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    fira-code
    fira-code-symbols
    dina-font
    proggyfonts
    open-sans
  ];


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
