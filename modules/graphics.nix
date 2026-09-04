#  _   _ _         ____                 _     _
# | \ | (_)_  __  / ___|_ __ __ _ _ __ | |__ (_) ___ ___
# |  \| | \ \/ / | |  _| '__/ _` | '_ \| '_ \| |/ __/ __|
# | |\  | |>  <  | |_| | | | (_| | |_) | | | | | (__\__ \
# |_| \_|_/_/\_\  \____|_|  \__,_| .__/|_| |_|_|\___|___/
#                                |_|
# -------------------------------------------------------
# Nix graphics module by lPhiNix
#
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
    # Base GPU acceleration, enabled for any provider.
    (lib.mkIf (cfg.provider != null) {
      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };
    })

    # Intel iGPU: use the media driver for VA-API.
    (lib.mkIf (cfg.provider == "intel") {
      hardware.graphics.extraPackages = [pkgs.intel-media-driver];
    })

    # AMD GPU: use the AMDVLK Vulkan driver.
    (lib.mkIf (cfg.provider == "amd") {
      hardware.graphics.extraPackages = [pkgs.amdvlk];
    })

    # NVIDIA: open kernel module, modesetting and settings app.
    (lib.mkIf (cfg.provider == "nvidia") {
      services.xserver.videoDrivers = lib.mkDefault ["nvidia"];
      hardware.nvidia = {
        # Use the open-source kernel module.
        open = true;
        modesetting.enable = true;
        nvidiaSettings = true;
        powerManagement = {
          enable = true;
          finegrained = true;
        };
        # PRIME offload: render on NVIDIA, display via the Intel iGPU.
        prime = {
          offload.enable = true;
          offload.enableOffloadCmd = true;
          nvidiaBusId = cfg.nvidia.busId;
          intelBusId = cfg.nvidia.iGpuBusId;
        };
      };
    })

    # Fail early if NVIDIA is selected without its bus IDs.
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
