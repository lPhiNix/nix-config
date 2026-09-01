{
  config,
  lib,
  pkgs,
  nixosConfig,
  ...
}: {
  home.packages = lib.mkIf nixosConfig.modules.gaming.enable (with pkgs; [
    
  ]);
}
