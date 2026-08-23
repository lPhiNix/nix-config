{
  config,
  lib,
  pkgs,
  nixosConfig,
  ...
}: {
  home.packages = lib.mkIf nixosConfig.modules.desktop.enable (with pkgs; [
    kitty
    nautilus
    uwsm
    vscode
    brave
    obsidian

    quickshell
    libnotify
    wl-clipboard
    cliphist
    hyprpicker
    cava

    ydotool
    gammastep
    papirus-icon-theme
    papirus-folders
    pwvucontrol

    adwaita-icon-theme
    nerd-fonts.jetbrains-mono
  ]);
}
