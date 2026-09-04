{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.graphics;
in {
  options.modules.graphics = {
    provider = lib.mkOption {
      type = lib.types.nullOr (lib.types.enum ["intel" "amd" "nvidia"]);
      default = null;
      description = "Primary system GPU: intel, amd or nvidia (null = disabled).";
    };

    nvidia = {
      busId = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "PCI BusID of the NVIDIA GPU for PRIME offload (e.g. PCI:1:0:0).";
      };
      iGpuBusId = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "PCI BusID of the iGPU for PRIME offload (e.g. PCI:0:2:0).";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf (cfg.provider != null) {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };
    })

    (lib.mkIf (cfg.provider == "intel") {
      hardware.graphics.extraPackages = [pkgs.intel-media-driver];
    })

    (lib.mkIf (cfg.provider == "amd") {
      hardware.graphics.extraPackages = [pkgs.amdvlk];
    })

    (lib.mkIf (cfg.provider == "nvidia") {
      services.xserver.videoDrivers = lib.mkDefault ["nvidia"];
      hardware.nvidia = {
        open = true;
        modesetting.enable = true;
        nvidiaSettings = true;
        powerManagement = {
          enable = true;
          finegrained = true;
        };
        prime = {
          offload.enable = true;
          offload.enableOffloadCmd = true;
          nvidiaBusId = cfg.nvidia.busId;
          intelBusId = cfg.nvidia.iGpuBusId;
        };
      };
    })

    {
      assertions = [
        {
          assertion = cfg.provider != "nvidia" || (cfg.nvidia.busId != "" && cfg.nvidia.iGpuBusId != "");
          message = "modules.graphics.provider = \"nvidia\" requires nvidia.busId and nvidia.iGpuBusId.";
        }
      ];
    }
  ];
}
