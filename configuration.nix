{ config, pkgs, ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    device = "/dev/sda";
    enable = true;
    version = 2;
  }; networking.hostName = "ghetto";

  networking.useDHCP = false;
  networking.interfaces.enp0s3.useDHCP = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16"; keyMap = "us";
  }; time.timeZone = "US/Eastern";

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    wget git rxvt_unicode feh xclip htop fortune 
    google-chrome stack zlib nix binutils xmobar
    atom neofetch scrot
  ];

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services = {
    openssh.enable = true;
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
      }; desktopManager.default = "none+xmonad";
      displayManager.startx.enable = true;
    }; compton = {
      enable = true; fade = true;
      inactiveOpacity = "0.95";
      shadow = true; fadeDelta = 4;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.defaultUserShell = pkgs.fish;
  security.sudo.wheelNeedsPassword = false;
  users.users.sheks = {
    description = "Shekychan";
    isNormalUser = true;
    extraGroups = [ "wheel" "audio"];
    uid = 1000;
  }; system.stateVersion = "20.03";

  nixpkgs.config = {
    virtualbox.enableExtenstionPack = true;
    pulseaudio = true; allowUnfree = true;
  };

  system.activationScripts.misc = {
    text = ''
      chown sheks:users -R /etc/nixos
      ln -sfn /run/current-system/sw/bin/bash /bin/bash
      cp -rsf /etc/nixos/sheks /home/
      chown sheks:users -R /home/sheks
    ''; deps = [];
  };

  systemd.user.services."urxvtd" = {
    enable = true;
    wantedBy = ["default.target"];
    path = [pkgs.rxvt_unicode];
    serviceConfig = {
      ExecStart = "${pkgs.rxvt_unicode}/bin/urxvtd -q -o";
      Restart = "always"; RestartSec = 2;
    };
  };

  fonts.fonts = with pkgs; [
    corefonts dejavu_fonts
    inconsolata liberation_ttf
    source-han-sans-japanese
    ubuntu_font_family
  ];

}

