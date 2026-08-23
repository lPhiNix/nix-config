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
    home.enable = true;
  };
}
