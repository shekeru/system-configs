{ config, pkgs, ... }:
let 
  NewAskPass = "${pkgs.x11_ssh_askpass}/libexec/ssh-askpass";
in {
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    device = "/dev/sda";
    enable = true;
    version = 2;
  };

  networking = {
    hostName = "ghetto"; useDHCP = false;
    interfaces.enp0s3.useDHCP = true;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16"; keyMap = "us";
  }; time.timeZone = "US/Eastern";

  nixpkgs.config = {
    virtualbox.enableExtenstionPack = true;
    pulseaudio = true; allowUnfree = true;
  };

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    wget git rxvt_unicode feh xclip htop fortune
    vscode atom neofetch scrot discord glib gnupg
    google-chrome stack zlib nix binutils xmobar
    ghc ruby python38 python38Packages.pip
    python38Packages.jupyter
    gvfs pcmanfm
  ];

  environment.sessionVariables = {
    SSH_ASKPASS = NewAskPass;
    ELECTRON_TRASH = "gio";
    EDITOR = "code";
  };

  # Program Configs
  programs = {
    ssh.askPassword = NewAskPass;
    gnupg.agent = {
      enableSSHSupport = true;
      enable = true; 
    };
  };

  # Mostly Display
  services = {
    xserver = {
      enable = true; layout = "us";
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = haskellPackages: [
          haskellPackages.xmonad-contrib
          haskellPackages.xmonad-extras
          haskellPackages.xmonad
        ];
      }; #desktopManager.default = "none+xmonad";
      displayManager.startx.enable = true;
    }; picom = {
      enable = true; shadow = true; 
      fade = true; fadeDelta = 4;
      inactiveOpacity = "0.85";
      activeOpacity = "0.95";
    }; openssh.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.fish;
  security.sudo.wheelNeedsPassword = false;
  users.users.sheks = {
    description = "Shekychan";
    uid = 1000; isNormalUser = true;
    extraGroups = [ "wheel" "audio" "docker"];
  }; system.stateVersion = "20.03";
  virtualisation.docker.enable = true;

  # Startup Scripts
  system.activationScripts.misc = {
    text = ''
      export SSH
      chown sheks:users -R /etc/nixos
      ln -sfn /run/current-system/sw/bin/bash /bin/bash
      cp -rsf /etc/nixos/sheks /home/
    ''; deps = [];
  };

  # Line History I think
  systemd.user.services."urxvtd" = {
    enable = true;
    wantedBy = ["default.target"];
    path = [pkgs.rxvt_unicode];
    serviceConfig = {
      ExecStart = "${pkgs.rxvt_unicode}/bin/urxvtd -q -o";
      Restart = "always"; RestartSec = 2;
    };
  };

  # Enable sound.
  hardware.pulseaudio.enable = true;
  sound.enable = true;

  # Extra Fonts
  fonts.fonts = with pkgs; [
    corefonts dejavu_fonts
    inconsolata liberation_ttf
    source-han-sans-japanese
    ubuntu_font_family lemon
  ];

}
