{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      "${builtins.fetchTarball
https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos"
    ];

  # Update Whenever (Ask Amel)
  networking.hostName = "shitbox";
  system.stateVersion = "18.03";

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  time.timeZone = "US/Eastern";

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  home-manager.users.sheks = {
    home.file.".config/fish/functions/".source = src/functions;
    home.file.".xmonad/xmonad.hs".source = src/xmonad/xmonad.hs;
    home.file.".Xdefaults".source = src/Xdefaults;
    home.file.".gitconfig".source = src/gitconfig;
    home.file.".urxvt/ext/".source = src/urxvt;
  };

  security.sudo.wheelNeedsPassword = false;
  environment.systemPackages = with pkgs; [
    wget git stack rxvt_unicode binutils nix mkpasswd
    linuxPackages.virtualboxGuestAdditions feh xclip
    atom elixir python3 erlang clojure leiningen
    llvmPackages.libclang gnumake google-chrome
    gnupg fortune
  ];

  users.mutableUsers = false;
  users.defaultUserShell = pkgs.fish;
  users.extraUsers.sheks = {
    hashedPassword = "$6$Gt0O1/wg6$ouOi0bA16sFWsGaQHAmVhDIZDYATXonLzZKBjrSY0J9QLpbMwOOCUz9UR/hnrWAgTqw9QaZlVQdrmNTCkgdqb1";
    description = "Sheky Sheks";
    extraGroups = ["wheel"];
    isNormalUser = true;
    uid = 1000;
  };

  programs.fish.enable = true;
  systemd.user.services."urxvtd" = {
    enable = true;
    description = "rxvt unicode daemon";
    wantedBy = [ "default.target" ];
    path = [ pkgs.rxvt_unicode ];
    serviceConfig.Restart = "always";
    serviceConfig.RestartSec = 2;
    serviceConfig.ExecStart = "${pkgs.rxvt_unicode}/bin/urxvtd -q -o";
  };

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
      videoDriver = "virtualbox";
      desktopManager.default = "none";
      displayManager.lightdm = {
        enable = true;
        extraSeatDefaults = ''
          greeter-show-manual-login=true
          greeter-hide-users=true
          autologin-user=sheks
          allow-guest=false
        '';
      };
      layout = "us";
    };
    compton = {
      enable          = true;
      fade            = true;
      inactiveOpacity = "0.9";
      shadow          = true;
      fadeDelta       = 4;
    };
  };

  fonts.fonts = with pkgs; [
    corefonts
    dejavu_fonts
    inconsolata
    liberation_ttf
    source-han-sans-japanese
    source-han-sans-korean
    source-han-sans-simplified-chinese
    source-han-sans-traditional-chinese
    ubuntu_font_family
  ];

  nixpkgs.config = {
    virtualbox.enableExtensionPack = true;
    pulseaudio = true; allowUnfree = true;
  };

}
