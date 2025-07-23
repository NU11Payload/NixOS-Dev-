{ config, pkgs, ... }:
{
  imports = [
     ./rdp.nix
     ./hardware-configuration.nix
     ./virtual.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
#Let my local LAN network know I use nix. As necessary.
  networking = {
    hostName = "iusenixosbtw";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
      # If you are reading my github repository, AllowedTCPPortsIP (I forgot what the article said but along the lines, is not real nix syntax, this is the only way I can find supported by documentation and in practice to whitelist an IP for iptables ):
      extraCommands = ''
        iptables -A INPUT -s 192.168.0.166 -p tcp --dport 3389 -j ACCEPT

        iptables -A INPUT -s 192.168.0.166 -p tcp --dport 22 -j ACCEPT
      '';
    };
  };
  # It's very hot here in arizona
  time.timeZone = "America/Phoenix";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  services = {
   xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    #services = {
    #   xrdp = {
#       openFirewall = true;
#       defaultWindowManager = true;
 #      enable = true;
   # };
  # };
#    displayManager.sddm.enable = true;
 #   desktopManager.plasma6.enable = true;
  #  printing.enable = true;
    openssh.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
#When it comes to KDE, you require pipewirepulse, so enable as per DE requirements
    };
  };
  # Yes, you need to do this for bluetooth
  hardware.bluetooth.enable = true;
  #Enable if you hate fast virtualization, otherwise use virtman


  # VirtualBox configuration - the "Why did I do this to my self, and use this instead of virtmanager" method
#  virtualisation.virtualbox.host = {
 #   enable = true;
  #  enableExtensionPack = true;  # Enables USB 2.0/3.0 support
  #};
  # users.extraGroups.vboxusers.members = [ "alanaa" ];




  users.users.alanaa = {
    isNormalUser = true;
    description = "Alanaa";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
      thunderbird
      discord # Environment packages are as implied, remove if system install, keep if per user
    ];
  };
  # You likely want this enabled
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    neovim # Keep this if you hate yourself, and mice
    qemu
    discord
    git
    # LazyVim dependencies - these work without flakes UPDATE: nvm they dont work
    lua
    luajit
    nodejs
    python3
    cargo
    rustc
    gcc
    unzip
    curl
    #tree-sitter
    #ripgrep
    fd
    lazygit
    # Language servers for LazyVim
    #nil  # Nix LSP
    #lua-language-server
    #rust-analyzer
    #pyright
    #nodePackages.typescript-language-server
    #nodePackages.bash-language-server
    # Formatters
    #stylua
    #black
    #nodePackages.prettier
    #rustfmt
    # Additional tools
    #glow
    htop
  ];

  programs = {
    firefox.enable = true;
    # mtr.enable = true;
    # gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };
    obs-studio = {
      enable = true;
      package = pkgs.obs-studio.override {
        cudaSupport = true; # enable if nvidia user
      };
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vaapi
        obs-gstreamer
        obs-vkcapture
      ];
    };
  };
  #Dont touch, I know you want to, but did you read the original notes? RTFM
  system.stateVersion = "25.05";
}
  
  system.stateVersion = "25.05";
}
