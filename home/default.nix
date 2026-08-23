{
  config,
  lib,
  inputs,
  ...
}: {
  options.modules.home.enable = lib.mkEnableOption "home-manager";

  config = lib.mkIf config.modules.home.enable {
    home-manager.useGlobalPkgs = true;

    home-manager.extraSpecialArgs = {
      inherit inputs;
      nixosConfig = config;
    };

    home-manager.users.phinix = {
      home.stateVersion = "26.05";

      imports = [
        ./packages.nix
        ./desktop.nix
        ./programs
      ];
    };
  };
}
