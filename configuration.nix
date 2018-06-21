{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      "${builtins.fetchTarball 
https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos"
    ];
  
  # Update Whenever (Ask Amel)
  system.stateVersion = "18.03"; 

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  # Networking/Internet Config
  networking.hostName = "shitbox";
  # networking.wireless.enable = true;

  # International Settings
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  fonts.fonts = with pkgs; [dejavu_fonts];

  # Timezones & Misc
  time.timeZone = "US/Eastern";

  # System Installed Packages (for all users?)
  environment.systemPackages = with pkgs; [
    wget git stack rxvt_unicode binutils nix
    # Xmonad Requirements
  ];

  home-manager.users.sheks = {
    home.file.".Xdefaults".source = src/Xdefaults;
    home.file.".gitconfig".source = src/gitconfig;
  };

  users.extraUsers.sheks = {
    description = "Sheky Sheks";
    extraGroups = ["wheel"];
    isNormalUser = true;
    uid = 1000;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  sound.enable = true;

  # Enable the X11 windowing system.
  services = {
    openssh.enable = true;
    xserver = {
      enable = true;
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        extraPackages = haskellPackages: [
          haskellPackages.xmonad-contrib
          haskellPackages.xmonad-extras
          haskellPackages.xmonad
        ];
      };
      layout = "us";
    };
  };

}
