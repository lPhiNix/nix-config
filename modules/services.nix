{
  config,
  lib,
  ...
}: {
  options.modules.services.enable = lib.mkEnableOption "servicios de red (SSH)";

  config = lib.mkIf config.modules.services.enable {
    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };

    networking.firewall = {
      enable = lib.mkDefault true;
      allowPing = lib.mkDefault true;
    };
  };
}
