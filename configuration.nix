{ config, lib, pkgs, ... }:

{
  imports =
    [
      /home/protopes/nixos-dotfiles/hardware-configuration.nix
    ];

  boot.loader.grub.enable = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.device = "/dev/sda";

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "sweet-home";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  users.users.protopes = {
     isNormalUser = true;
     createHome = true;
     openssh.authorizedKeys.keyFiles = [
       "/etc/secrets/initrd/authorized_key_rsa1"
     ];
     extraGroups = [ "wheel" ];
   };

  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
     vim
     wget
     git
     tmux
     xray
   ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # More packages is good
  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.

  programs.mtr.enable = true;
  programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };


  # Docker is our friend
  virtualisation.docker.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
    settings.PermitRootLogin = "no";
  };

  services.xray = {
    enable = true;
    settingsFile = "/etc/xray/conf.json";
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 53 80 1080 443 8096 60040 ];
  networking.firewall.allowedUDPPorts = [ 53 80 443 1080 7359 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "25.05";

}
