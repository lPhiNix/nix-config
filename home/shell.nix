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

    figlet # ASCII text generator
    cava # Audio visualizer

    cmatrix # Matrix digital rain
    tty-clock # Terminal clock
    cbonsai # Growing bonsai tree
    pipes # Pipes terminal screensaver
    sl # Steam locomotive runs on 'sl'
    hollywood # Fake 'hacker' console activity
  ];
}
