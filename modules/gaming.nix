{
  config,
  lib,
  ...
}: {
  options.modules.gaming.enable = lib.mkEnableOption "Gaming (Steam)";

  config = lib.mkIf config.modules.gaming.enable {
    programs.steam = {
      enable = true;
    };
  };
}
