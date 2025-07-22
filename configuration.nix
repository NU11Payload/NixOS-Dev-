{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  networking = {
    hostName = "iusenixosbtw";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
      # If you need IP-specific rules, use extraCommands instead:
      extraCommands = ''
        iptables -A INPUT -s 192.168.0.166 -p tcp --dport 22 -j ACCEPT
      '';
    };
  };
  
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
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    printing.enable = true;
    openssh.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
  
  hardware.bluetooth.enable = true;
  
  # VirtualBox configuration - Enhanced setup
  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;  # Enables USB 2.0/3.0 support
  };
  users.extraGroups.vboxusers.members = [ "alanaa" ];
  
  users.users.alanaa = {
    isNormalUser = true;
    description = "Alanaa";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
      thunderbird
      discord
    ];
  };
  
  nixpkgs.config.allowUnfree = true;
  
  environment.systemPackages = with pkgs; [
    vim
    wget
    neovim
    qemu
    discord
    git
    # LazyVim dependencies - these work without flakes
    lua
    luajit
    nodejs
    python3
    cargo
    rustc
    gcc
    unzip
    curl
    tree-sitter
    ripgrep
    fd
    lazygit
    # Language servers for LazyVim
    nil  # Nix LSP
    lua-language-server
    rust-analyzer
    pyright
    nodePackages.typescript-language-server
    nodePackages.bash-language-server
    # Formatters
    stylua
    black
    nodePackages.prettier
    rustfmt
    # Additional tools
    glow
    btop
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
        cudaSupport = true;
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
  
  system.stateVersion = "25.05";
} config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  networking = {
    hostName = "iusenixosbtw";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
      # If you need IP-specific rules, use extraCommands instead:
      extraCommands = ''
        iptables -A INPUT -s 192.168.0.166 -p tcp --dport 22 -j ACCEPT
      '';
    };
  };
  
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
    displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;
    printing.enable = true;
    openssh.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
  
  hardware.bluetooth.enable = true;
  
  # VirtualBox configuration - Enhanced setup
  virtualisation.virtualbox.host = {
    enable = true;
    enableExtensionPack = true;  # Enables USB 2.0/3.0 support
  };
  users.extraGroups.vboxusers.members = [ "alanaa" ];
  
  users.users.alanaa = {
    isNormalUser = true;
    description = "Alanaa";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
      thunderbird
      discord
    ];
  };
  
  nixpkgs.config.allowUnfree = true;
  
  environment.systemPackages = with pkgs; [
    vim
    wget
    neovim
    qemu
    discord
    git
    # LazyVim dependencies - these work without flakes
    lua
    luajit
    nodejs
    python3
    cargo
    rustc
    gcc
    unzip
    curl
    tree-sitter
    ripgrep
    fd
    lazygit
    # Language servers for LazyVim
    nil  # Nix LSP
    lua-language-server
    rust-analyzer
    pyright
    nodePackages.typescript-language-server
    nodePackages.bash-language-server
    # Formatters
    stylua
    black
    nodePackages.prettier
    rustfmt
    # Additional tools
    glow
    btop
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
        cudaSupport = true;
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
  
  system.stateVersion = "25.05";
}
