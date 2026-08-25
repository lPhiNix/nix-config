{
  config,
  lib,
  ...
}: {
  options.modules.gaming.enable = lib.mkEnableOption "gaming (Steam)";

  config = lib.mkIf config.modules.gaming.enable {
    programs.steam = {
      enable = true;
    };
  };
}
