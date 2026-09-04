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
  home.packages =
    lib.mkIf nixosConfig.modules.gaming.enable (with pkgs; [
      ]);
}
