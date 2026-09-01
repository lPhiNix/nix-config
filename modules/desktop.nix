{
  config,
  lib,
  ...
}: {
  options.modules.desktop.enable = lib.mkEnableOption "Hyprland desktop";

  config = lib.mkIf config.modules.desktop.enable {
    programs.hyprland.enable = true;

    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;

    hardware.bluetooth.enable = true;

    services.geoclue2.enable = true;
    services.gvfs.enable = true;
    services.udisks2.enable = true;
  };
}
