{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages
    ];
  };

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      flake-registry = "";
      auto-optimise-store = true;
    };
    channel.enable = false;
  };

  boot.loader.systemd-boot.enable = lib.mkDefault true;
  boot.loader.efi.canTouchEfiVariables = lib.mkDefault true;

  networking.networkmanager.enable = true;

  services.udev.packages = [pkgs.yubikey-personalization];

  time.timeZone = lib.mkDefault "Europe/Madrid";
  i18n.supportedLocales = ["en_US.UTF-8/UTF-8" "es_ES.UTF-8/UTF-8"];
  console.keyMap = "es";

  system.stateVersion = "26.05";
}
