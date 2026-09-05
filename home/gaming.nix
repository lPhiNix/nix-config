#    _  ___        _____           _
#   / |/ (_)_ __  / ___/__ ___ _  (_)__  ___ _
#  /    / /\ \ / / (_ / _ `/  ' \/ / _ \/ _ `/
# /_/|_/_//_\_\  \___/\_,_/_/_/_/_/_//_/\_, /
#                                      /___/
# --------------------------------------------
# Gaming nix home packages by lPhiNix
#
{
  config,
  lib,
  pkgs,
  nixosConfig,
  ...
}: {
  config = lib.mkIf nixosConfig.modules.gaming.enable {
    home.packages = with pkgs; [
      (writeShellScriptBin "osu" ''
        unset LD_LIBRARY_PATH
        export XDG_DATA_HOME="$HOME/.games/osu/data"
        mkdir -p "$XDG_DATA_HOME"
        exec ${osu-lazer-bin}/bin/osu! "$@"
      '')
    ];
    xdg.desktopEntries."osu" = {
      name = "osu!";
      comment = "Rhythm is just a *click* away";
      exec = "${config.home.profileDirectory}/bin/osu";
      icon = "${pkgs.osu-lazer-bin}/share/icons/hicolor/512x512/apps/osu.png";
      terminal = false;
      categories = ["Game"];
      settings.StartupWMClass = "osu!";
    };
  };
}
