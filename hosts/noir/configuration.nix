{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "noir";

  users.users.phinix = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager"];
  };

  modules = {
    desktop.enable = true;
    audio.enable = true;
    services.enable = true;
    gaming.enable = true;
    home.enable = true;
    
    graphics = {
      provider = "nvidia";
      nvidia = {
        busId = "PCI:1:0:0";
        iGpuBusId = "PCI:0:2:0";
      };
    };
  };
}
