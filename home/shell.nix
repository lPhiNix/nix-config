#    _  ___        ______       ____
#   / |/ (_)_ __  / __/ /  ___ / / /
#  /    / /\ \ / _\ \/ _ \/ -_) / /
# /_/|_/_//_\_\ /___/_//_/\__/_/_/
# ----------------------------------
# Shell nix home packages by lPhiNix
#
{pkgs, ...}: {
  home.packages = with pkgs; [
    fish # Shell (command interpreter)

    starship # Shell prompt
    fastfetch # System fetch

    figlet # Cli ASCII text generator
    cava # Cli audio visualizer
  ];
}
