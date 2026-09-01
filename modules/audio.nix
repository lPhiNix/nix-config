{
  config,
  lib,
  ...
}: {
  options.modules.audio.enable = lib.mkEnableOption "Audio PipeWire";

  config = lib.mkIf config.modules.audio.enable {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };
}
